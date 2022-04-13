# frozen_string_literal: true

module LinkHelper
  def link_to_access_request_approve(access_request, options = {})
    html_class = options[:class]
    url = approve_access_request_path(access_request)
    options = {
      method: :put,
      class: ["btn btn-outline-success btn-sm", html_class].compact.join(" "),
      title: "Approve this request",
      data: {
        "bs-toggle" => "tooltip",
        confirm: "Approve #{access_request.user.name} for access to your ward?",
      },
    }
    link_to fa_icon("check-circle"), url, options
  end

  def link_to_access_request_reject(access_request, options = {})
    html_class = options[:class]
    url = reject_access_request_path(access_request)
    options = {
      method: :put,
      class: ["btn btn-outline-danger btn-sm", html_class].compact.join(" "),
      title: "Reject this request",
      data: {
        "bs-toggle" => "tooltip",
        confirm: "Reject #{access_request.user.name} from access to your ward?",
      },
    }
    link_to fa_icon("times-circle"), url, options
  end

  def link_to_delete(resource_or_array, options = {})
    html_class = options[:class]
    url = polymorphic_path(resource_or_array)
    resource = if resource_or_array.is_a?(Array)
                 resource_or_array.last
               else
                 resource_or_array
               end

    resource_name = resource.class.name.underscore.humanize(capitalize: false)
    options = {
      method: :delete,
      class: ["btn btn-outline-danger btn-sm", html_class].compact.join(" "),
      title: "Delete #{resource_name}",
      data: {
        "bs-toggle" => "tooltip",
        confirm: "Delete this #{resource_name}?",
        turbo: false,
      },
    }
    link_to fa_icon("trash"), url, options
  end

  def link_to_edit(resource_or_array, options = {})
    html_class = options[:class]
    url = edit_polymorphic_path(resource_or_array)
    resource = if resource_or_array.is_a?(Array)
                 resource_or_array.last
               else
                 resource_or_array
               end

    resource_name = resource.class.name.underscore.humanize(capitalize: false)
    options = {
      class: ["btn btn-outline-primary btn-sm", html_class].compact.join(" "),
      title: "Edit #{resource_name}",
      data: {
        "bs-toggle" => "tooltip",
      },
    }
    link_to fa_icon("pencil-alt"), url, options
  end

  def link_to_meeting_delete(meeting, options = {})
    link_to_delete(meeting, options)
  end

  def link_to_meeting_edit(meeting, options = {})
    link_to_edit(meeting, options)
  end

  def link_to_member_delete(member, options = {})
    link_to_delete(member, options)
  end

  def link_to_member_edit(member, options = {})
    link_to_edit(member, options)
  end

  def link_to_note_delete(note, options = {})
    link_to_delete([note.member, note], options)
  end

  def link_to_note_edit(note, options = {})
    link_to_edit([note.member, note], options)
  end

  def link_to_talk_delete(talk, options = {})
    link_to_delete([talk.meeting, talk], options)
  end

  def link_to_talk_edit(talk, options = {})
    link_to_edit([talk.meeting, talk], options)
  end
end
