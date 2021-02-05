FROM ruby:2.5
COPY . /var/www/ruby  
WORKDIR /var/www/ruby  
CMD ["ruby","planet_data_processor.rb"]