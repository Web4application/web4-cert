docker run --rm \
  -e WEB4_CA_NAME="WEB4 Root CA" \
  -e WEB4_CODE_NAME="CI Builder" \
  -e WEB4_SERVER_NAME="ci.web4.com" \
  -e WEB4_SERVER_SANS="ci.web4.com,api.web4.com" \
  -v $(api)/web4_certs:/app/web4_certs \
  web4-cert-generator
ls $(api)/web4_certs
openssl x509 -in "$(api)/web4_certs/ci.web4.com.crt" -text -noout
openssl verify -CAfile "$(api)/web4_certs/WEB4 Root CA.crt" "$(api)/web4_certs/ci.web4.com.crt"
openssl s_server -cert "$(api)/web4_certs/ci.web4.com.crt" -key "$(api)/web4_certs/ci.web4.com.key" -accept 8443
openssl s_client -connect localhost:8443 -CAfile "$(api)/web4_certs/WEB4 Root CA.crt"
