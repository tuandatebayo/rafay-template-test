output "helm_release_status" {
  description = "Status of the Helm release."
  value       = helm_release.nim_service.status
}

output "service_endpoint" {
  description = "Endpoint of the NIM service (if exposed via LoadBalancer)."
  # Logic để lấy điểm cuối sẽ phụ thuộc vào cách biểu đồ Helm hiển thị dịch vụ.
  # Đây là một ví dụ giả định, bạn cần điều chỉnh nó.
  value = try(kubernetes_service.nim_service[0].status[0].load_balancer[0].ingress[0].hostname, null)
  # Hoặc bạn có thể cần sử dụng `data "kubernetes_service"` để lấy thông tin sau khi triển khai
}