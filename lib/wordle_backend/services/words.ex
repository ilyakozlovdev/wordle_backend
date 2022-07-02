defmodule WordleBackend.Services.Words do
  alias WordleBackend.Models.Word

  def migrate do
    File.read!(filename())
    |> Jason.decode!()
    |> Map.to_list()
    |> Enum.filter(fn {word, _} -> String.length(word) == 5 end)
    |> Enum.map(fn {word, %{"definition" => definition}} ->
      %Word{
        original: word,
        downcased: String.downcase(word),
        definition: definition
      }
    end)
    |> Enum.uniq_by(fn %Word{downcased: downcased} -> downcased end)
    |> Enum.sort_by(fn %Word{downcased: downcased} -> downcased end)
    |> Enum.map(&WordleBackend.Repo.insert!/1)
  end

  defp filename do
    Keyword.get(Application.get_env(:wordle_backend, __MODULE__, [filename: ""]), :filename)
  end
end
