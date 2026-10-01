# AI Prompt Log

## 1. Brainstorm về 1D và 2D

**Prompt:** Khi một child cần chiếm chính xác 2 hàng và 2 cột trong Bento Dashboard, nên dùng CSS Grid hay Flexbox? Tại sao?

**Kết luận sử dụng:** Chọn CSS Grid vì Grid quản lý đồng thời hàng và cột, phù hợp với widget span 2 chiều.

## 2. Phân biệt Flexbox và Grid

**Prompt:** Flexbox và CSS Grid có thể kết hợp không? Nếu một widget nằm trong Grid nhưng cần căn giữa icon và text thì dùng gì?

**Kết luận sử dụng:** Có thể kết hợp; Grid lo layout Dashboard, Flexbox lo căn chỉnh nội dung bên trong từng widget.

## 3. Bootstrap Pricing

**Prompt:** Trong Bootstrap 5, col-12 col-md-4 hoạt động thế nào?

**Kết luận sử dụng:** Dùng col-12 để full-width trên màn hình nhỏ và col-md-4 từ breakpoint md trở lên, tạo 3 cột bằng nhau mà không cần media query riêng.

## 4. gap

**Prompt:** gap có thể thay thế margin lộn xộn trong Flexbox và Grid thế nào?

**Kết luận sử dụng:** Dùng gap cho khoảng cách giữa các item trong .mh-menu và .grid-dashboard để cấu trúc CSS rõ ràng hơn.

## 5. Responsive test

**Prompt:** Làm thế nào để Navbar Flexbox tự xuống dòng và Dashboard Grid chuyển về 1 cột trên mobile?

**Kết luận sử dụng:** Navbar dùng flex-wrap: wrap; Dashboard thêm breakpoint nhỏ để chuyển grid-template-columns thành 1fr và reset các span về 1 cột.
