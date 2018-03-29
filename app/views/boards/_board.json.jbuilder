json.extract! board, :id, :name, :topic_id :created_at, :updated_at
json.url board_url(board, format: :json)
