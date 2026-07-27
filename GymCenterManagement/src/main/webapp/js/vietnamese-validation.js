(function () {
    const DEFAULT_IMAGE_EXTENSIONS = ["jpg", "jpeg", "png", "gif", "webp"];

    function allowedExtensions(field) {
        const configured = field.dataset.allowedExtensions;
        if (!configured) {
            return DEFAULT_IMAGE_EXTENSIONS;
        }
        return configured
                .split(",")
                .map(extension => extension.trim().toLowerCase())
                .filter(Boolean);
    }

    function fileExtension(fileName) {
        const dotIndex = fileName.lastIndexOf(".");
        if (dotIndex < 0 || dotIndex === fileName.length - 1) {
            return "";
        }
        return fileName.substring(dotIndex + 1).toLowerCase();
    }

    function validateFileInput(field) {
        const file = field.files && field.files[0];
        if (!file) {
            field.setCustomValidity("");
            return true;
        }

        const extension = fileExtension(file.name || "");
        if (!allowedExtensions(field).includes(extension)) {
            field.setCustomValidity(field.dataset.fileMessage || "Ảnh chỉ hỗ trợ định dạng jpg, jpeg, png, gif hoặc webp.");
            return false;
        }

        field.setCustomValidity("");
        return true;
    }

    function bindRequiredMessages(root) {
        root.querySelectorAll("[data-required-message]").forEach(field => {
            field.addEventListener("invalid", function () {
                if (field.validity.valueMissing) {
                    field.setCustomValidity(field.dataset.requiredMessage);
                }
            });

            ["input", "change"].forEach(eventName => {
                field.addEventListener(eventName, function () {
                    if (!field.matches("[data-allowed-extensions]")) {
                        field.setCustomValidity("");
                    }
                });
            });
        });
    }

    function bindFileMessages(root) {
        const fileInputs = Array.from(root.querySelectorAll("input[type='file'][data-allowed-extensions]"));
        fileInputs.forEach(field => {
            field.addEventListener("change", function () {
                validateFileInput(field);
            });
        });

        root.querySelectorAll("form").forEach(form => {
            form.addEventListener("submit", function (event) {
                const firstInvalidFile = fileInputs.find(field => form.contains(field) && !validateFileInput(field));
                if (firstInvalidFile) {
                    event.preventDefault();
                    firstInvalidFile.reportValidity();
                }
            });
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        bindRequiredMessages(document);
        bindFileMessages(document);
    });
})();
