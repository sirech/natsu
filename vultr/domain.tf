locals {
  sub_domains = ["cookery2", "echo", "shelf2"]
}

resource "vultr_dns_domain" "domain" {
  domain = var.domain
}

resource "vultr_dns_record" "domain_main" {
  domain = vultr_dns_domain.domain.id
  name   = ""
  data   = var.server_ip
  type   = "A"

  ttl = local.ttl
}

resource "vultr_dns_record" "domain_cname" {
  domain = vultr_dns_domain.domain.id
  name   = "*"
  data   = var.domain
  type   = "CNAME"

  ttl = local.ttl
}

resource "vultr_dns_record" "domain_subdomain" {
  for_each = local.sub_domains

  domain = vultr_dns_domain.domain.id
  name   = each.value
  data   = var.server_ip
  type   = "A"

  ttl = local.ttl
}
