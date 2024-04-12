docker build -t eco .
docker run -it --rm -d -p 80:80 --name eco eco
