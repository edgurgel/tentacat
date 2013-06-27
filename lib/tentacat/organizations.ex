defmodule Tentacat.Organizations do
  defmacro __using__(_) do

    import Tentacat.Client.Base
    quote do
      @doc """
      List all public organizations for a user

      ## Example

          client.organizations "edgurgel"

      More info at: http://developer.github.com/v3/orgs/#list-user-organizations
      """
      @spec organizations(binary, Client.t) :: :jsx.json_term
      def organizations(user, self) do
        get "users/#{user}/orgs", self.auth
      end

      @doc """
      List public and private organizations for the authenticated user

      ## Example

          client.organizations

      More info at: http://developer.github.com/v3/orgs/#list-user-organizations
      """
      @spec organizations(Client.t) :: :jsx.json_term
      def organizations(self) do
        get "users/orgs", self.auth
      end

      @doc """
      Get an organization

      ## Example

          client.organizations "Codeminer42"

      More info at: http://developer.github.com/v3/orgs/#get-an-organization
      """
      @spec organization(binary, Client.t) :: :jsx.json_term
      def organization(org, self) do
        get "orgs/#{org}", self.auth
      end

      @doc """
      Update an organization

      Possible values for `options`:

      * [billing_email: "billing email"]
      * [company: "Company42"]
      * [email: "public email"]
      * [location: "Brazil"]
      * [name: "company42"]

      ## Example

          client.update_organization("codeminer42", [email: "public@codeminer42.com", location: "São Paulo"])

      More info at: http://developer.github.com/v3/orgs/#edit-an-organization
      """
      @spec update_organization(binary, list, Client.t) :: :jsx.json_term
      def update_organization(org, options, self) do
        patch "orgs/#{org}", self.auth, options
      end

    end
  end
end
