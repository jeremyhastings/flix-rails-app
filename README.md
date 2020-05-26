# Flix Rails App

Flix is a Movie Listing and Registration application.  Guests can see the movies that are listed.  Guests can sign up for an account to become a user.  Users can like and favorite movies.  Admins can add movies and categories for categorization of the movie.  This application uses all the different types of models and relationships.  One to Many, Many to Many, and through Association via Join Models.  It uses the bcrypt gem for authentication and basic helper methods for authorization.  It uses scope for order the listings, a method to create user-friendly urls, stores the images using local active storage for development and Amazon Web Services S3 for the images with a Heroku deployment.

## Getting Started

These instructions will allow you to make a copy of the project yourself, and get it up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

RubyMine 2019.3, Ruby 2.6.6, and Rails 6.0.2.2 were used to initially make this project on a machine with SQLite.  I try to keep the application up to date so if the latest commit doesn't work try going back to an earlier one.

## FOR REFERENCE:

### Active Storage Uploads

In the terminal:

```shell
$ rails active_storage:install
```

Followed by:

```shell
rails db:migrate
```

Declare association in the Movie model:

```ruby
has_one_attached :main_image
```

Update movies form partial:

```ruby
<%= f.label :main_image %>
<%= f.file_field :main_image %>
```

Add :main_image to movie_params in MoviesController:

```ruby
def movie_params
  params.require(:movie).permit(... :main_image ...)
end
```

Create a main_image method in MoviesHelper:

```ruby
def main_image(movie)
  if movie.main_image.attached?
    image_tag movie.main_image
  else
    image_tag "placeholder.png"
  end
end
```

Use helper for displaying iamge:

```ruby
<%= main_image(movie) %>
```



## Running the tests

Tests to come at a later date.  Want to write some?

## Deployment

Should easily deploy to Heroku.  Instructions for that at a later date if needed.

## Built With

* [Ruby](https://www.ruby-lang.org/en/) - Language
* [Ruby on Rails](https://rubyonrails.org) - MVC Framework
* [RubyMine](https://www.jetbrains.com/ruby/) - IDE
* [PostgreSQL](https://www.postgresql.org) - Database

## Contributing

If you want to ...

## Authors

* **Jeremy Hastings** - *Initial work* - [Jeremy Hastings](https://github.com/jeremyhastings/)

## License

This project is licensed under the GNU General Public License 3.0 License - see the [LICENSE.md](LICENSE.md) file for details
