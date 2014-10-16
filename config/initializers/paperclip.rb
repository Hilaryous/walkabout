Paperclip::Attachment.default_options.merge!(
  url:                  ':s3_domain_url',
  path:                 'sights/images/',
  storage:              :s3,
  s3_credentials:       "#{Rails.root}/config/aws.yml",
  bucket:                'hilarywalkabout',
  s3_permissions:       :private,
  s3_protocol:          'https'
)

Paperclip::Attachment.default_options[:use_timestamp] = false
