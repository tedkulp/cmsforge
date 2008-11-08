class ProjectMailer < ActionMailer::Base

  def project_submission(project)
    
    config = SimpleConfig.for(:application)
    
    from "no-reply@cmsmadesimple.org"
    recipients ["no-reply@cmsmadesimple.org"]
    
    bcc_list = []    
    User.find_all_by_superuser(1).each do |user|
      bcc_list << user.email unless user.nil? or user.email.nil?
    end
    
    if config.send_bcc
      bcc bcc_list
    else
      cc ["ted@tedkulp.com"]
    end
    
    subject "New Forge Project Submitted"
    
    content_type "text/plain"
    
    body :project => project, :url => config.host
    
  end
  
  def project_acceptance(project)
    
    config = SimpleConfig.for(:application)
    
    from "no-reply@cmsmadesimple.org"
    recipients ["no-reply@cmsmadesimple.org"]
    
    bcc_list = []    
    project.users.each do |user|
      bcc_list << user.email unless user.nil? or user.email.nil?
    end
    User.find_all_by_superuser(1).each do |user|
      bcc_list << user.email unless user.nil? or user.email.nil?
    end
    
    if config.send_bcc
      bcc bcc_list
    else
      cc ["ted@tedkulp.com"]
    end
    
    subject "[#{project.name}] Project Accepted!"
    
    content_type "text/plain"
    
    body :project => project, :url => config.host
    
  end
  
  def project_rejection(project)
    
    config = SimpleConfig.for(:application)
    
    from "no-reply@cmsmadesimple.org"
    recipients ["no-reply@cmsmadesimple.org"]
    
    bcc_list = []    
    project.users.each do |user|
      bcc_list << user.email unless user.nil? or user.email.nil?
    end
    User.find_all_by_superuser(1).each do |user|
      bcc_list << user.email unless user.nil? or user.email.nil?
    end
    
    if config.send_bcc
      bcc bcc_list
    else
      cc ["ted@tedkulp.com"]
    end
    
    subject "[#{project.name}] Project Rejected"
    
    content_type "text/plain"
    
    body :project => project, :url => config.host
    
  end

end
