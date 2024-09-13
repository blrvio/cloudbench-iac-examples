
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um domínio do CloudSearch
resource "aws_cloudsearch_domain" "my_domain" {
  name = "my-domain"
}

# Crie um índice de pesquisa
resource "aws_cloudsearch_index" "my_index" {
  domain_id = aws_cloudsearch_domain.my_domain.id
  name      = "my-index"

  options = <<EOF
{
    "indexFields": [
        {
            "fieldName": "title",
            "indexFieldType": "text",
            "fieldOptions": {
                "index": true,
                "store": true
            }
        },
        {
            "fieldName": "content",
            "indexFieldType": "text",
            "fieldOptions": {
                "index": true,
                "store": true
            }
        }
    ]
}
EOF
}

# Carregue dados no índice
resource "aws_cloudsearch_document" "my_document" {
  domain_id = aws_cloudsearch_domain.my_domain.id
  id        = "1"

  fields = <<EOF
{
    "title": "My Document Title",
    "content": "This is the content of my document."
}
EOF
}
    