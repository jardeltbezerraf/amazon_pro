class ApplicationController < ActionController::Base
  # Permitir apenas navegadores modernos que suportem imagens webp, notificações push na web, badges, mapas de importação, aninhamento de CSS e CSS :has.
  allow_browser versions: :modern

  # Alterações no mapa de importação invalidarão o etag para respostas HTML
  stale_when_importmap_changes
end
