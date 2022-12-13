Rails.application.routes.draw do
  
  root "lab10_ser#input"
  get 'lab10_ser/input'
  get 'lab10_ser/show'
  get 'lab10_ser/some_transformer.xslt', to: 'lab10_ser#some_transformer'
end
