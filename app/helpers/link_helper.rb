# frozen_string_literal: true

module LinkHelper
  def link_to_meeting_delete(meeting, options = {})
    html_class = options[:class]
    url = meeting_path(meeting)
    options = { method: :delete,
                data: { confirm: "This will delete the meeting and cannot be undone. Are you sure you want to proceed?",
                        turbo: false },
                class: ["btn btn-danger btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("trash"), url, options
  end

  def link_to_meeting_edit(meeting, options = {})
    html_class = options[:class]
    url = edit_meeting_path(meeting)
    options = { class: ["btn btn-primary btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("pencil-alt"), url, options
  end

  def link_to_member_delete(member, options = {})
    html_class = options[:class]
    url = member_path(member)
    options = { method: :delete,
                data: { confirm: "This will delete the member and cannot be undone. Are you sure you want to proceed?",
                        turbo: false },
                class: ["btn btn-danger btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("trash"), url, options
  end

  def link_to_member_edit(member, options = {})
    html_class = options[:class]
    url = edit_member_path(member)
    options = { class: ["btn btn-primary btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("pencil-alt"), url, options
  end

  def link_to_note_delete(note, options = {})
    html_class = options[:class]
    url = member_note_path(note.member, note)
    options = { method: :delete,
                data: { confirm: "This will delete the note and cannot be undone. Are you sure you want to proceed?",
                        turbo: false },
                class: ["btn btn-danger btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("trash"), url, options
  end

  def link_to_note_edit(note, options = {})
    html_class = options[:class]
    url = edit_member_note_path(note.member, note)
    options = { class: ["btn btn-primary btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("pencil-alt"), url, options
  end

  def link_to_talk_delete(talk, options = {})
    html_class = options[:class]
    url = talk_path(talk)
    options = { method: :delete,
                data: { confirm: "This will delete the talk and cannot be undone. Are you sure you want to proceed?",
                        turbo: false },
                class: ["btn btn-danger btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("trash"), url, options
  end

  def link_to_talk_edit(talk, options = {})
    html_class = options[:class]
    url = edit_talk_path(talk)
    options = { class: ["btn btn-primary btn-sm", html_class].compact.join(" ") }
    link_to fa_icon("pencil-alt"), url, options
  end
end
