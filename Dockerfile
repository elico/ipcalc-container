FROM nginxinc/nginx-unprivileged:stable-alpine

LABEL maintainer "Eliezer Croitoru <ngtech1ltd@gmail.com>"

COPY /files/ipcalc.conf /etc/nginx/conf.d/ipcalc.conf
RUN rm /etc/nginx/nginx.conf

COPY /files/nginx.conf /etc/nginx/
COPY /files/www/ /usr/share/nginx/html/

USER root

RUN rm -vf /var/log/nginx/* && rm -rf /etc/nginx/conf.d/default.conf \
	&& chown -R nginx /usr/share/nginx/html/ \
	&& chown nginx /etc/nginx/conf.d/ipcalc.conf \
	&& chmod 400 /etc/nginx/conf.d/ipcalc.conf \
	&& chown nginx /etc/nginx/nginx.conf \
	&& chmod 400 /etc/nginx/nginx.conf 

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/* 
RUN update-ca-certificates

USER 101

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
