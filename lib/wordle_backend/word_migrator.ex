defmodule WordleBackend.WordMigrator do
  def migrate do
    File.read!('./assets/data.json')
    |> Jason.decode!()
    |> Map.to_list()
    |> Enum.filter(fn {word, _} -> String.length(word) == 5 end)
    |> Enum.map(fn {word, %{"definition" => definition}} ->
      %WordleBackend.Word{
        original: word,
        downcased: String.downcase(word),
        definition: definition
      }
    end)
    |> Enum.uniq_by(fn %WordleBackend.Word{downcased: downcased} -> downcased end)
    |> Enum.sort_by(fn %WordleBackend.Word{downcased: downcased} -> downcased end)
    |> Enum.each(&WordleBackend.Repo.insert!/1)
  end
end
