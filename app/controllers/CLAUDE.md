Follow these coding conventions for controllers:

- DRY up instance variable assignment with callbacks, for example `before_action :set_todo` instead of calling `@todo = Todo.find(params[:id])` repeatedly.
- Use Rails I18n translations for user-facing messages rather than hard-coding text.
