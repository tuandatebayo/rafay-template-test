# Đảm bảo không gian tên tồn tại hoặc tạo nó
resource "kubernetes_namespace" "nim_namespace" {
  metadata {
    name = var.var_namespace
  }
}

# (Tùy chọn) Lấy khóa API NGC từ Kubernetes secret
data "kubernetes_secret" "ngc_api_key" {
  metadata {
    name      = var.var_ngc_api_key_secret
    namespace = kubernetes_namespace.nim_namespace.metadata[0].name # Hoặc không gian tên nơi secret tồn tại
  }
}

resource "helm_release" "nim_service" {
  name       = "nim-${lower(replace(var.var_nim_model, "_", "-"))}" # Tên bản phát hành Helm duy nhất
  repository = var.var_nim_helm_repo_url
  chart      = var.var_nim_helm_chart_name
  version    = var.var_nim_helm_chart_version
  namespace  = kubernetes_namespace.nim_namespace.metadata[0].name

  # Các giá trị được truyền cho biểu đồ Helm
  # Tham khảo tài liệu biểu đồ Helm của NVIDIA NIM để biết các giá trị có thể cấu hình
  values = [
    yamlencode({
      model = {
        name = var.var_nim_model
        # Các cấu hình mô hình khác nếu cần
      }
      ngc = {
        apiKey = democracia.kubernetes_secret.ngc_api_key.data["NGC_API_KEY"] # Giả sử khóa trong secret là NGC_API_KEY
        # Hoặc nếu bạn truyền trực tiếp giá trị API key (ít an toàn hơn)
        # apiKey = var.ngc_api_key_value
      }
      # Các tùy chọn cấu hình khác của biểu đồ NIM
      # ví dụ: replicas, resources (cpu, memory, gpu), service type, ingress, etc.
      resources = {
        limits = {
          nvidia_com_gpu = 1 # Yêu cầu 1 GPU
        }
      }
      # ... thêm các giá trị khác theo yêu cầu của biểu đồ NIM
    })
  ]

  # (Tùy chọn) Chờ cho các tài nguyên sẵn sàng
  wait = true
  timeout = 600 # Thời gian chờ tính bằng giây

  depends_on = [kubernetes_namespace.nim_namespace]
}