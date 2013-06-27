defmodule Tentacat.Gitignore do
  defmacro __using__(_) do
    import Tentacat.Client.Base
    quote do
      @doc """
      List all templates available

      ## Example

          client.gitignore_templates

      More info at: http://developer.github.com/v3/gitignore/#listing-available-templates
      """
      @spec gitignore_templates(Client.t) :: :jsx.json_term
      def gitignore_templates(self) do
        get "gitignore/templates", self.auth
      end

      @doc """
      Get a single template based on the `name`

      ## Example

          client.gitignore_template "C"

      More info at: http://developer.github.com/v3/gitignore/#get-a-single-template
      """
      # FIXME We should support raw data type too
      @spec gitignore_template(binary, Client.t) :: :jsx.json_term
      def gitignore_template(name, self) do
        get "gitignore/templates/#{name}", self.auth
      end
    end
  end
end

