docker run --rm \
  -e WEB4_CA_NAME="WEB4 Root CA" \
  -e WEB4_CODE_NAME="CI Builder" \
  -e WEB4_SERVER_NAME="ci.web4.com" \
  -e WEB4_SERVER_SANS="ci.web4.com,api.web4.com" \
  -v $(api)/web4_certs:/app/web4_certs \
  web4-cert-generator
