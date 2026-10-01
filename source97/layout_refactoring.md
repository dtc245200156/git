# Layout Refactoring Audit

## 3 điểm chết cần loại bỏ

| Khu vực | Legacy | Giải pháp |
|---|---|---|
| Author Info | 'float: left/right', 'overflow: hidden' | Flexbox: 'd-flex align-items-center justify-content-between', thêm 'flex-wrap' cho mobile |
| Mosaic Gallery | 'position: absolute', chiều cao cứng 400px | CSS Grid + 'grid-template-areas'; mobile về 1 cột |
| Recommended Articles | 'float: left', 'width: 23%', margin phần trăm | Bootstrap Grid: 'row' + 'col-12 col-md-6 col-lg-3' |

## Báo cáo refactoring

Legacy 'position: absolute' làm phần tử con rời khỏi normal flow nên chiều cao của vùng cha không còn được suy ra từ các ảnh. Khi viewport nhỏ hơn, các phần tử chỉ bám theo tọa độ và chiều cao 400px đã đặt trước, vì vậy gallery có thể chồng lên phần nội dung kế tiếp. Vấn đề đặc biệt rõ khi ảnh thay đổi tỷ lệ hoặc văn bản phía trên xuống dòng nhiều hơn.

CSS Grid giải quyết bài toán này bằng cách mô tả trực tiếp cấu trúc hai chiều của gallery. Ở desktop, 'grid-template-areas' đặt ảnh chính chiếm hai hàng, hai ảnh phụ chiếm hai ô bên phải; chiều cao của gallery được Grid quản lý theo track thay vì một con số cố định. Ở mobile, media query chuyển sang một cột, nên từng ảnh nằm trong normal flow và tự xếp chồng. Nhờ 'object-fit: cover', ảnh vẫn lấp đầy ô mà không bị méo. Cách này giảm phụ thuộc vào pixel và phù hợp với Responsive Design hơn layout absolute cũ.

## Responsive breakpoint map

- Desktop ≥ 992px: Author nằm một hàng; Mosaic 2 cột, ảnh chính chiếm 2 hàng; Recommended 4 cột.
- Tablet 768–991px: Author linh hoạt; Mosaic vẫn giữ Grid 2 cột; Recommended 2 cột.
- Mobile < 768px: Author có thể xuống dòng; Mosaic 1 cột; Recommended 1 cột.
