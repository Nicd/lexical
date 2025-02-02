defmodule Lexical.StructAccess do
  defmacro __using__(_) do
    quote location: :keep do
      def fetch(struct, key) when is_map_key(struct, key) do
        {:ok, Map.get(struct, key)}
      end

      def fetch(_, _) do
        :error
      end

      def get_and_update(struct, key, function) when is_map_key(struct, key) do
        old_value = Map.get(struct, key)

        case function.(old_value) do
          {current_value, updated_value} -> {current_value, Map.put(struct, key, updated_value)}
          :pop -> {old_value, Map.put(struct, key, nil)}
        end
      end

      def get_and_update(struct, key, function) do
        {{:error, {:nonexistent_key, key}}, struct}
      end

      def pop(struct, key) when is_map_key(struct, key) do
        {Map.get(struct, key), struct}
      end

      def pop(struct, _key) do
        {nil, struct}
      end
    end
  end
end
