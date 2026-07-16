# jamoviAI

Module tích hợp AI vào [jamovi](https://www.jamovi.org) để tự động phân tích và giải thích dữ liệu thống kê bằng tiếng Việt.

## Các module

### 1. API AI (`apiAI`)

Gửi dữ liệu đến API OpenAI-compatible (cloud) để phân tích.

| Tham số | Mô tả | Mặc định |
|---------|-------|----------|
| `input_text` | Nội dung bảng số liệu | — |
| `api_url` | Endpoint API | `https://api.openai.com/v1/chat/completions` |
| `api_key` | API Key | — |
| `model_name` | Tên model | `gpt-4o-mini` |
| `system_prompt` | Prompt hướng dẫn AI | "Bạn là chuyên gia phân tích số liệu..." |

### 2. Local AI (`aiExplain`)

Chạy model AI cục bộ qua [Ollama](https://ollama.com), không cần internet.

| Tham số | Mô tả | Mặc định |
|---------|-------|----------|
| `input_text` | Nội dung bảng số liệu | — |
| `ollama_url` | Endpoint Ollama local | `http://localhost:11434/v1/chat/completions` |
| `model_name` | Tên model | `deepseek-r1:14b` |
| `system_prompt` | Prompt hướng dẫn AI | "Bạn là chuyên gia phân tích số liệu..." |

## Cách sử dụng

### Trong jamovi Desktop

1. Cài đặt module: sao chép thư mục này vào `~/.jamovi/modules/`
2. Mở jamovi, vào menu **Analyses** → **AI**
3. Chọn **API AI** (dùng cloud) hoặc **Local AI** (dùng Ollama)
4. Copy bảng số liệu từ jamovi, dán vào ô **input_text**
5. Nhấn **Run** — kết quả giải thích hiện ra ngay bên dưới

### Qua R (command line)

```r
library(jamoviAI)

# Dùng OpenAI
apiAI(
  input_text  = "Mẫu: n=100, Mean=45.2, SD=12.1",
  api_key     = "sk-...",
  model_name  = "gpt-4o-mini"
)

# Dùng Ollama local
aiExplain(
  input_text  = "Mẫu: n=100, Mean=45.2, SD=12.1",
  model_name  = "deepseek-r1:14b"
)
```

## Yêu cầu

- jamovi ≥ 2.0
- R packages: `jmvcore`, `httr`, `jsonlite`
- Ollama (cho Local AI)

## Tác giả

Nguyễn Minh Toàn — nguyenminhtoan@iuh.edu.vn
