requireNamespace("httr")
requireNamespace("jsonlite")

aiExplainClass <- R6::R6Class(
    "aiExplainClass",
    inherit = aiExplainBase,
    private = list(
        .processing = FALSE,

        .init = function() {
            raw_text <- self$options$input_text
            if (is.null(raw_text) || raw_text == "") {
                self$results$text_output$setContent("Vui lòng nhập nội dung bảng số liệu.")
            } else {
                self$results$text_output$setContent("Đang chờ AI phản hồi...")
            }
        },

        .run = function() {
            if (private$.processing) return()
            raw_text <- self$options$input_text
            if (is.null(raw_text) || raw_text == "") return()

            private$.processing <- TRUE
            on.exit(private$.processing <- FALSE)

            body <- list(
                model = self$options$model_name,
                messages = list(
                    list(role = "system", content = self$options$system_prompt),
                    list(role = "user", content = raw_text)
                ),
                stream = FALSE
            )

            res <- tryCatch({
                httr::POST(url = self$options$ollama_url, body = body, encode = "json", httr::timeout(120))
            }, error = function(e) {
                self$results$text_output$setContent(paste0("Lỗi kết nối: ", e$message))
                return(NULL)
            })

            if (!is.null(res) && httr::status_code(res) == 200) {
                result_json <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"), simplifyVector = FALSE)
                ai_text <- result_json[["choices"]][[1]][["message"]][["content"]]
                if (is.null(ai_text)) ai_text <- result_json[["message"]][["content"]]
                self$results$text_output$setContent(ai_text)
            } else if (!is.null(res)) {
                self$results$text_output$setContent(paste0("Lỗi HTTP ", httr::status_code(res)))
            }
        }
    )
)
