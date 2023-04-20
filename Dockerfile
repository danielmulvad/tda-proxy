FROM nginx:1.23-alpine3.17

RUN mkdir -p /etc/nginx/ssl
RUN --mount=type=secret,id=PRIVATE_CERTIFICATE_CERT cat /run/secrets/PRIVATE_CERTIFICATE_CERT > /etc/nginx/ssl/cert.pem
RUN --mount=type=secret,id=PRIVATE_CERTIFICATE_KEY cat /run/secrets/PRIVATE_CERTIFICATE_KEY > /etc/nginx/ssl/key.pem

# Copy the nginx configuration file
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80
EXPOSE 443

# Run nginx
CMD ["nginx", "-g", "daemon off;"]