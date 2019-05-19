document.addEventListener("turbolinks:load", event => {
  const form = document.querySelector("#upload_files");
  const selectedFiles = document.querySelector("#selected-files");
  form.onchange = formEvent => {
    Object.values(formEvent.target.files)
      .map(file => file.name)
      .forEach((fileName, index) => {
        let fileEntry = document.createElement("div");
        fileEntry.className = "direct-upload direct-upload--pending";
        fileEntry.id = `direct-upload-${index + 1}`;
        let progress = document.createElement("div");
        progress.className = "direct-upload__progress";
        progress.id = `direct-upload-progress-${index + 1}`;
        progress.style.width = "0%";
        let fileEntrySpan = document.createElement("span");
        fileEntrySpan.innerHTML = fileName;
        fileEntrySpan.className = "direct-upload__filename";
        fileEntry.appendChild(progress);
        fileEntry.appendChild(fileEntrySpan);
        selectedFiles.appendChild(fileEntry);
      });
  };
});

addEventListener("direct-upload:initialize", event => {
  const selectedFiles = document.querySelector("#selected-files");
  const { target, detail } = event
  const { id, file } = detail
  // target.insertAdjacentHTML("beforebegin", `<span>File Uploading</span>`)
  selectedFiles.appendChild(`
        <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
          <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
          <span class="direct-upload__filename">${file.name}</span>
        </div>
      `)
})

addEventListener("direct-upload:start", event => {
  const { id } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.remove("direct-upload--pending")
})

addEventListener("direct-upload:progress", event => {
  const { id, progress } = event.detail
  const progressElement = document.getElementById(`direct-upload-progress-${id}`)
  progressElement.style.width = `${progress}%`
})

addEventListener("direct-upload:error", event => {
  event.preventDefault()
  const { id, error } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.add("direct-upload--error")
  element.setAttribute("title", error)
})

addEventListener("direct-upload:end", event => {
  const { id } = event.detail
  const element = document.getElementById(`direct-upload-${id}`)
  element.classList.add("direct-upload--complete")
})
