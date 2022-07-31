<template>
	<div class="my-modal" style="padding-right: 17px; display: block"
		
	>
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 id="exampleModalLabel" class="modal-title mt-0">
						Modal title
					</h5>
					<button
						type="button"
						data-dismiss="modal"
						aria-label="Close"
						class="close"
					>
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="toast-body">
						<form method="post"></form>
						<input
							type="hidden"
							name="csrfmiddlewaretoken"
							value="zTdvhvUJjMO6Ie4kIVahhNGcW6PLG8EmfAI5CXzT2EliF8DOYxDCCjHVtYt2DdXR"
						/>
						Are you sure you want to delete ?
					</div>
					<button class="btn btn-danger btn-small">
						<a href="#">Confirm</a>
					</button>
				</div>
			</div>
		</div>
	</div>
</template>
<style scoped>
.my-modal {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	z-index: 1000;
	background-color: rgb(0, 0, 0, 0.2);
	display: none;
}
.show {
	display: block;
}
</style>

