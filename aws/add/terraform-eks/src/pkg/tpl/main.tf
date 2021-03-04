terraform {
	required_version = "0.13.5"
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "3.3.0"
		}
		kubernetes = {
			source  = "hashicorp/kubernetes"
			version = "1.11.1"
		}
		local = {
			source  = "hashicorp/local"
			version = "1.4.0"
		}
		template = {
			source  = "hashicorp/template"
			version = "2.1.2"
		}
		helm = {
			source  = "hashicorp/helm"
			version = "1.3.0"
		}
		external = {
			source  = "hashicorp/external"
			version = "1.2.0"
		}
		tls = {
			source  = "hashicorp/tls"
			version = "2.1.1"
		}
		archive = {
			source  = "hashicorp/archive"
			version = "1.3.0"
		}
		random = {
			source  = "hashicorp/random"
			version = "2.2.1"
		}
	}
}
