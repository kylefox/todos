import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    const todoId = event.target.dataset.todoId
    const completed = event.target.checked
    
    const formData = new FormData()
    formData.append("todo[completed]", completed)
    formData.append("_method", "patch")
    
    fetch(`/todos/${todoId}`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept": "text/vnd.turbo-stream.html"
      },
      body: formData
    })
  }
}