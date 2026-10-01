# Source 94 - MetricsHub UI

Bài thực hành tái cấu trúc layout từ Legacy Code theo nguyên tắc chọn đúng công cụ:

- **Navbar → Flexbox**: 1 chiều, content-first, tự co giãn và wrap.
- **Bento Dashboard → CSS Grid**: 2 chiều, dùng grid-column/grid-row span.
- **Pricing → Bootstrap Grid**: dùng hệ 12 cột với `col-12 col-md-4`.

## Tệp

- `metricshub_ui/index.html`
- `metricshub_ui/style.css`
- `layout_strategy.md`
- `ai_prompt_log.md`

## Chạy bài

Mở `metricshub_ui/index.html` bằng trình duyệt có Internet để Bootstrap CDN được tải.

## Responsive

Desktop: Dashboard 4 cột, Pricing 3 cột.
Tablet: Dashboard 2 cột.
Mobile: Navbar tự wrap, Dashboard 1 cột, Pricing xếp dọc bằng Bootstrap.

## Ghi chú

Các file được tổ chức đúng cấu trúc bài nộp yêu cầu và phần giải trình chiến lược nằm dưới 150 từ.
