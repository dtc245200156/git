# Source 40 - GitHub: Tạo Repository mới

## Mục tiêu

Thực hành quy trình cơ bản khi tạo một dự án Git và đồng bộ mã nguồn từ Local Repository lên Remote Repository trên GitHub.

## Ý nghĩa các câu lệnh đã sử dụng

### 1. Khởi tạo Local Repository

`git init`

Khởi tạo một Git Repository trong thư mục dự án hiện tại. Git bắt đầu theo dõi lịch sử thay đổi của dự án.

### 2. Kết nối Local với Remote Repository

`git remote add origin https://github.com/codegym-vn/my-new-project.git`

Thêm Remote Repository và đặt tên định danh là `origin`. Sau bước này Local Repository biết nơi cần đồng bộ mã nguồn lên GitHub.

### 3. Đưa file vào Staging Area

`git add README.md`

Đưa file `README.md` vào Staging Area để chuẩn bị cho lần commit tiếp theo.

### 4. Tạo Commit

`git commit -m "Add README.md file"`

Lưu snapshot các thay đổi đã được đưa vào staging. Tùy chọn `-m` dùng để ghi message mô tả nội dung của commit.

### 5. Đẩy mã nguồn lên GitHub

`git push origin master`

Đẩy các commit từ nhánh Local `master` lên Remote Repository `origin`.

> Lưu ý: các repository GitHub hiện nay thường sử dụng nhánh `main` thay cho `master`. Khi dùng nhánh `main), có thể sử dụng:
>
> `git push -u origin main`

Tùy chọn `-u` thiết lập upstream để những lần push sau có thể sử dụng lệnh ngắn gọn hơn.

## Luồng làm việc

```
Tạo Repository trên GitHub
        ↓
Tạo thư mục dự án Local
        ↓
git init
        ↓
git remote add origin <repository-url>
        ↓
Tạo README.md
        ↓
git add README.md
        ↓
git commit -m "Add README.md file"
        ↓
git push origin main
        ↓
Local Repository ↔ Remote Repository
```

## Link Repository

Repository đang sử dụng để lưu bài tập:

https://github.com/dtc245200156/git

## Cấu trúc bài nộp

source40/
└── README.md
