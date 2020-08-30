FROM nginx:1.17

COPY sample-app/build /usr/share/nginx/html


EXPOSE 80 443 	

CMD ["nginx", "-g", "daemon off;"]