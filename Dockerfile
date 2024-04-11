FROM debian:bookworm-slim as build
WORKDIR /ecoventure
COPY . .

RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-yaml
RUN python3 scripts/csv2yml.py projects_data/projects.csv projects_data/projects.yml
RUN apt-get install -y ruby
RUN gem install mustache
RUN mustache projects_data/projects.yml site/projects.html.mustache > site/projects.html

FROM nginx:latest
COPY --from=build /ecoventure/site/ /usr/share/nginx/html/
