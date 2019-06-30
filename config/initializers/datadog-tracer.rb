Datadog.configure do |c|
  c.tracer(
      enabled: Rails.env.production?,
      hostname: "datadog-agent",
      tags: {
          env: 'qiitan_prod',
          product: 'qiitan',
          project: 'qiitan',
          role: 'qiitan',
      }
  )

  c.use :rails,
        service_name: 'qiitan-rails-app',
        controller_service: 'qiitan-rails-controller',
        database_service: 'qiitan-mysql'
end
