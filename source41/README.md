# Source 41 - GitHub: Clone Repository

## Mục tiêu

Thực hành thao tác **clone** một Repository có sẵn từ GitHub về máy và hiểu cú pháp cũng như ý nghĩa của câu lệnh `git clone`.

## Cú pháp

```bash
git clone <repository-url>
```

Ví dụ:

```bash
git clone https://github.com/codegym-vn/wf-hello.git
```

Có thể chỉ định tên thư mục đích:

```bash
git clone <repository-url> <folder-name>
```

## Ý nghĩa của câu lệnh git clone

`git clone` dùng để tạo một bản sao hoàn chỉnh của một Git Repository từ Remote Repository về máy tính local.

Khi clone, Git sẽ:

- Tải mã nguồn và lịch sử commit của Repository về máy.
- Tạo một thư mục local chứa dự án.
- Tự động khởi tạo thư mục `.git`.
- Thiết lập remote mặc định có tên `origin` trỏ tới Repository đã clone.
- Giúp có thể tiếp tục làm việc với các lệnh `git add`, `git commit`, `git pull` và `git push`.

## Repository thực hành

Repository theo đề bài:

https://github.com/codegym-vn/wf-hello

Lệnh clone:

```bash
git clone https://github.com/codegym-vn/wf-hello.git
```

Sau khi clone thành công, di chuyển vào thư mục:

```bash
cd wf-hello
```

Kiểm tra remote:

```bash
git remote -v
```

## Quy trình

```
GitHub Repository
       ↓
git clone <repository-url>
       ↓
Local Repository
       ↓
cd <project-folder>
       ↓
Tiếp tục phát triển dự án
```

## Kết luận

Lệnh `git clone` là thao tác dùng để sao chép một Repository có sẵn từ GitHub hoặc một Git server khác về local. Đây thường là bước đầu tiên khi tham gia phát triển một dự án đã tồn tại.

## Link Repository lưu bài

https://github.com/dtc245200156/git
