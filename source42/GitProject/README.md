# GitProject

Bài thực hành Git và GitHub: clone repository, tạo file README.md, tạo thư mục source và đồng bộ mã nguồn lên remote repository.

## Nội dung dự án

- README.md: mô tả dự án.
- source/index.html: trang HTML chính.
- source/news.html: trang tin tức.

## Các lệnh Git đã thực hành

```bash
git clone https://github.com/<tai-khoan>/GitProject.git
git add README.md
git commit -m "Add README.md"
git push origin main

git add source/
git commit -m "Add source files"
git push origin main
```

## Ý nghĩa

### git clone
Sao chép một repository từ remote về máy local, đồng thời thiết lập repository local và remote `origin`.

### git add
Đưa file hoặc thư mục vào Staging Area để chuẩn bị commit.

### git commit -m "message"
Lưu một phiên bản thay đổi vào lịch sử Git và gắn message mô tả nội dung thay đổi.

### git push origin main
Đẩy các commit của nhánh `main` từ local lên remote `origin`.

## Cấu trúc

```text
GitProject/
├── README.md
└── source/
    ├── index.html
    └── news.html
```

## Link repository nộp bài

https://github.com/dtc245200156/git
