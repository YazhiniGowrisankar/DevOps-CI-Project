FROM nginx:latest

# copy ONLY the website folder content
COPY food-funday-master/ /usr/share/nginx/html/

EXPOSE 80