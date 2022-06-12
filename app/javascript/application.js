// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "popper"
import "bootstrap"
import  "trix"
import "@rails/actiontext"
import Rails from '@rails/ujs'

document.addEventListener("DOMContentLoaded", function() {
    let elements = document.querySelectorAll('.estimation-level')
    elements.forEach(function(e) {
        // e.addEventListener('click', function (event) {
        //     const skill_id = event.target.getAttribute("data-index");
        //     const data = skill_id.split("-")
        //     Rails.ajax({
        //         type: "POST",
        //         url: `/skills/${data[0]}/estimation_skills`,
        //         data: `estimation=${data[1]}`,
        //         async: false,
        //         success: function(data2){
        //             console.log(skill_id)
        //             let old_code = this.parentElement
        //             this.parentElement.innerHTML = data2
        //         }.bind(this),
        //         error: function(data2){
        //         }
        //     })
        // })
    })
    let elements2 = document.querySelectorAll('.reset_estimation_link')
    elements2.forEach(function(e) {
        e.addEventListener('click', function (event) {
            let skill_id = event.target.getAttribute("data-index");
            Rails.ajax({
                type: "POST",
                url: `/skills/${skill_id}/estimation_skills`,
                data: `estimation=0`,
                success: function(data){
                },
                error: function(data){
                }
            })
        })
    })

})

window.updateEstimation = function qwer(e) {
    const skill_id = e.getAttribute("data-index");
    const data = skill_id.split("-")
    Rails.ajax({
        type: "POST",
        url: `/skills/${data[0]}/estimation_skills`,
        data: `estimation=${data[1]}`,
        async: false,
        success: function(data2){
            console.log(skill_id)
            debugger
            let old_code = this.parentElement
            this.parentElement.innerHTML = data2
        }.bind(e),
        error: function(data2){
        }
    })

}

window.resetEstimation = function resetEstimation(e) {
    let skill_id = event.target.getAttribute("data-index");
    Rails.ajax({
        type: "POST",
        url: `/skills/${skill_id}/estimation_skills`,
        data: `estimation=0`,
        success: function(data2){
            let old_code = this.parentElement.parentElement
            old_code.innerHTML = data2
        }.bind(e),
        error: function(data){
        }
    })
}




window.updateEstimationItem = function qwer(e) {
    const skill_id = e.getAttribute("data-index");
    const data = skill_id.split("-")
    Rails.ajax({
        type: "POST",
        url: `/skill_level_items/${data[0]}/estimation_skill_level_items`,
        data: `estimation=${data[1]}`,
        async: false,
        success: function(data2){
            console.log(skill_id)
            debugger
            let old_code = this.parentElement
            this.parentElement.innerHTML = data2
        }.bind(e),
        error: function(data2){
        }
    })

}

window.resetEstimationItem = function resetEstimation(e) {
    let skill_id = event.target.getAttribute("data-index");
    Rails.ajax({
        type: "POST",
        url: `/skill_level_items/${skill_id}/estimation_skill_level_items`,
        data: `estimation=0`,
        success: function(data2){
            let old_code = this.parentElement.parentElement
            old_code.innerHTML = data2
        }.bind(e),
        error: function(data){
        }
    })
}
// function asdf() {
//     const skill_id = event.target.getAttribute("data-index");
//     const data = skill_id.split("-")
//     Rails.ajax({
//         type: "POST",
//         url: `/skills/${data[0]}/estimation_skills`,
//         data: `estimation=${data[1]}`,
//         async: false,
//         success: function(data2){
//             console.log(skill_id)
//             let old_code = this.parentElement
//             this.parentElement.innerHTML = data2
//         }.bind(this),
//         error: function(data2){
//         }
//     })
// }
// document.addEventListener("DOMContentLoaded", function(event) {
//     console.log("DOM fully loaded and parsed");
// });

window.updateCompleteMaterial = function updateCompleteMaterial() {
    let materialId = event.target.getAttribute("data-material-id");

    Rails.ajax({
        type: "POST",
        url: `/learning_materials/${materialId}/complete_materials`,
        data: `is_completed=${event.target.checked}`,
        success: {},
        error: {}
    })
}
