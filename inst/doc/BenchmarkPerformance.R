## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

if (!nativeORT::ort_is_installed()) {
  knitr::opts_chunk$set(eval=FALSE)
}

## ----load,include=FALSE, eval = FALSE-----------------------------------------
# library(nativeORT)
# library(ggplot2)
# 
# model_path <- file.path(tools::R_user_dir("nativeORT", "data"), "yolo11n.onnx")
# 
# if (!file.exists(model_path)) {
#   message("Downloading YOLOv11 model (~12Mb)...")
#   dir.create(dirname(model_path), recursive=TRUE, showWarnings = FALSE)
#   utils::download.file(
#     url="https://github.com/ultralytics/assets/releases/download/v8.4.0/yolo11n.onnx",
#     destfile=model_path,
#     mode="wb"
#   )
#   message("yolo11n.onnx downloaded!")
# }

## ----benchmark, eval = FALSE--------------------------------------------------
# # typical RGB 256x256 image
# input <- array(
#   runif(1 * 3 * 256 * 256),
#   dim=c(1L, 3L, 256L, 256L)
# )
# 
# session <- nativeORT::ort_session(model_path,
#                                   threads=0L,
#                                   opt_level=99L)
# 
# times_cpu <- numeric(100)
# for (i in 1:100){
#   times_cpu[i] <- system.time(
#     nativeORT::ort_infer_raw(session, input)
#   )["elapsed"] * 1000
# }
# 
# # CoreML
# dir.create(path.expand("~/.nativeORT/cache"),
#            recursive = TRUE, showWarnings = FALSE
#            )
# session <- nativeORT::ort_session(model_path,
#                                   provider='coreml',
#                                   cache_dir=path.expand("~/.nativeORT/cache"),
#                                   threads=0L,
#                                   opt_level=99L
#            )
# 
# times_coreml <- numeric(100)
# for (i in 1:100){
#   times_coreml[i] <- system.time(
#     nativeORT::ort_infer_raw(session, input)
#   )["elapsed"] * 1000
# }

## ----plot, fig.width=7, eval = FALSE------------------------------------------
# results <- data.frame(
#   run=rep(1:length(times_cpu), 2),
#   provider=c(
#     rep("CPU (nativeORT)", length(times_cpu)),
#     rep("CoreML (nativeORT)", length(times_coreml))
#   ),
#   latency_ms=c(times_cpu, times_coreml)
# )
# 
# ggplot(results, aes(x=run, y=latency_ms, color=provider)) +
#   geom_line() +
#   geom_hline(yintercept=33.3, linetype="dashed", color="red") +
#   annotate("text", x=85, y=40, label="29.97 fps threshold") +
#   labs(
#     title="Inference Latency Across Inference Engines",
#     subtitle="YOLOv11n, 256x256 Images, Apple M1",
#     x="Run",
#     y="Latency (ms)"
#   ) +
#   theme_minimal()

