variable "var_target_cluster_name" {
  type        = string
  description = "The name of the target Kubernetes cluster."
}

variable "var_nim_model" {
  type        = string
  description = "NVIDIA NIM model to deploy."
}

variable "var_namespace" {
  type        = string
  default     = "nim-services"
  description = "Kubernetes namespace for NIM deployment."
}

variable "var_ngc_api_key_secret" {
  type        = string
  description = "Kubernetes secret name containing the NGC API Key."
}

variable "var_nim_helm_repo_url" {
  type        = string
  description = "NVIDIA NIM Helm chart repository URL."
}

variable "var_nim_helm_chart_name" {
  type        = string
  description = "NVIDIA NIM Helm chart name."
}

variable "var_nim_helm_chart_version" {
  type        = string
  description = "Version of the NVIDIA NIM Helm chart."
}