terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11" # Hoặc phiên bản tương thích mới hơn
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20" # Hoặc phiên bản tương thích mới hơn
    }
  }
}

# Quan trọng: Cấu hình nhà cung cấp Kubernetes
# Rafay agent sẽ cần quyền truy cập vào cụm mục tiêu.
# Nếu agent chạy trong cụm mục tiêu, cấu hình này có thể đơn giản hơn.
# Nếu không, bạn cần đảm bảo kubeconfig được cung cấp hoặc có sẵn.
# Rafay thường xử lý việc này khi một tác nhân được liên kết với một cụm.
# Trong nhiều trường hợp, bạn có thể không cần khai báo khối `provider "kubernetes"`
# một cách rõ ràng nếu tác nhân Rafay và môi trường thực thi đã được thiết lập đúng cách
# để nhắm mục tiêu vào `var_target_cluster_name`.
# Tuy nhiên, nếu bạn cần rõ ràng:
provider "kubernetes" {
  # Kubeconfig có thể được lấy từ nhiều nguồn:
  # 1. Một tệp trên tác nhân (nếu được mount)
  # 2. Dữ liệu từ một tài nguyên Rafay (nếu có)
  # 3. Biến môi trường
  # Đơn giản nhất, nếu tác nhân có quyền, nó có thể không cần cấu hình rõ ràng.
  # config_path = "~/.kube/config" # Hoặc đường dẫn thích hợp
}

provider "helm" {
  kubernetes {
    # Tham chiếu đến cấu hình nhà cung cấp Kubernetes ở trên
    # config_path = "~/.kube/config" # Đảm bảo điều này khớp
  }
}