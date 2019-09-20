defmodule Tentacat.Users.KeysTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users.Keys

  doctest Tentacat.Users.Keys

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})
  @public_key "\
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyRrmeVAhXGZzlS41WQGiJ5krjn3Lm\
UBkoInDxRT0BRk9B8BT6HXHJubcrzCbhJi2NR7/h89xOlQ8g8/cXjonHVeUvcXib76Ww\
nMVyOA1oUYELlo+iMREXPOe2Y4n+kToj2vavF9mClYsZ8fd34B/4Wpn+laFyK1dopo0t\
fkxxzX7GQs1smawzXg8Vz7tp/2TAuyiDqLKmiNGEhJDbCg2ZSqf1YtNPgKR+QDzeJvBW\
Lhn9AW9BiLfBmuFVEcGE39ydIF6zmtpliZRjVHD3q53TauAsqY4MFDRRVhavlZiVFct+\
IYduYZqSFr7593Huyyj8EtMmnn7qufW3uKTqJR+47I3V4ASwbZp+Uf2WYWOtxufIEsy9\
NwU9GLe78ko89MPykrHvas3vAyYvWG85duuc0xkOtlXfdbKKyNN0CBziQ24boRVpwQbY\
0xn6TemxNXvObYDSrqUpZ6J/g2VkWfX/SRz96qGXS9beBPowzzphvbDo0SrXGm7lw1f0\
SyzPtteeAgxKUKSPrpFsO9ZWgW5owGhBZSLEpnvuF6QxyXptKToBp4/mKA1OmeXsVAdJ\
2vQf+WKn2CNRkctCsjX1FEY4r09/15qgpz4aaMBUfz+Nlf4YKZU9yBNZqZqVCuvY/QqL\
sOpeb6IzgbBaxuQ9Jlpu2JgzMst0ArBNkPI3ER6ppQ== your_email@example.com "

  setup_all do
    HTTPoison.start()
  end

  test "list/2" do
    use_cassette "users/keys#list" do
      assert elem(list(@client, "soudqwiggle"), 1) == []
    end
  end

  test "list_mine/1" do
    use_cassette "users/keys#list_mine" do
      assert elem(list_mine(@client), 1) == []
    end
  end

  test "find/2" do
    use_cassette "users/keys#find" do
      %{"verified" => verified} = elem(find(@client, 15_057_833), 1)
      assert verified == true
    end
  end

  test "create/3" do
    use_cassette "users/keys#create" do
      {status_code, _, _} = create(@client, "test key", @public_key)
      assert status_code == 201
    end
  end

  test "update/4" do
    use_cassette "users/keys#update" do
      {405, %{"message" => message}, _} =
        update(@client, 15_057_833, "updated test key", "ssh-rsa AAA...")

      assert message ==
               "Method not allowed. To make changes to a key, delete the existing key and add a new one with the desired attributes."
    end
  end

  test "remove/2" do
    use_cassette "users/keys#remove" do
      {status_code, _, _} = remove(@client, 15_057_833)
      assert status_code == 204
    end
  end
end
