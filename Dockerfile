# Fetching the latest nginx image
FROM nginx

# Copying built assets from builder
COPY . /usr/share/nginx/html

# Copying our nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 100
# Start nginx
CMD ["nginx", "-g", "daemon off;"]
