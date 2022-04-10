defmodule Estatistica do
  def sumVector(list) when is_list(list), do: list |> Enum.sum # Pipe passando o valor para Enum.sum
  def mode(list) when is_list(list) do
      Enum.reduce(list, {%{}, 0, []}, fn(v, {a, hc, hv}) -> # Passa cada elemento da lista para a função no terceiro argumento, mantendo a estrutura do segundo argumento como contador
        case Map.update(a, v, 1, &(&1+1)) do # 'v' sendo o valor passado pelo reduce como o valor do array 'a' ser percorrido e os 2 ultimos argumentos ou definindo o valor do dicionario como 1 ou iterando 1 no valor
          %{^v => ^hc}=a -> {a, hc, [v | hv]} # Se o valor da contagem tiver o maior numero ou igual essa linha é executada para aquele valor do array
          %{^v => c}=a when c>hc -> {a, c, [v]} #Caso chegue nessa linha define o valor da contagem para o atual e se esse valor for maior que o atual maior valor de contagem o define na resposta
          a -> {a, hc, hv} # Caso seja a primeira vez que esteja ocorrendo essa repetição essa linha é executada
        end
      end)
  end

  def median(list) when is_list(list) do
    require Integer
    if Integer.is_even(length(list)) do
      getPositions = &({&1, div(length(&1),2), div(length(&1)+1,2)})
      getNumbers = fn(l)->
        case l do
          {a,b,c} = _ -> [Enum.at(a, b), Enum.at(a, c)]
        end
      end
      media = &(div(&1,2))
      Enum.sort(list) |> getPositions.() |> getNumbers.() |> Enum.sum |> media.()
    else
      Enum.sort(list) |> length() |> (&div(&1-1,2)).() |>  (&Enum.at(list, &1)).()
    end
  end

  def mean(list) when is_list(list) do
    list |> (&(Enum.sum(&1)/length(&1))).()
  end

  def harmonicMean(list) when is_list(list) do
    Enum.map(list, fn x -> 1 / x end) |> (&(length(&1)/Enum.sum(&1))).()
  end
end

IO.puts(Estatistica.harmonicMean([50,60]))
