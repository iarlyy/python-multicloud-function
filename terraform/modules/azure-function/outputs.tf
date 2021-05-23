output "function_name" {
  value = element(concat(azurerm_function_app.this.*.name, [""]), 0)
}
