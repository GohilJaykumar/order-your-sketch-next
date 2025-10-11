FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY . /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 7001

CMD ["nginx", "-g", "daemon off;"]
#