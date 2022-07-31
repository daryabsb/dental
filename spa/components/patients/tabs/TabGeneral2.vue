<template>
	<div>
		<b-row>
			<!-- <pre>{{examinations}}</pre> -->
			<b-col class="px-0">
<b-card>
                                    <b-card-title>
                                            <template>


												
                                                <h2 class="text-pink text-uppercase mt-0">Clinical Examinations</h2>
												<span
											class="text-muted font-weight-normal"
										>These examinations were updated on: {{$moment(examinations.updated).format('DD/MM/yyyy')}}</span>
                                            </template>
                                            </b-card-title>
								</b-card>



				<b-row>

					<b-col>
						<!-- TREATMENT PLAN -->
						<b-card>
							<b-card-body>
								<template>
									<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
									<h4 class="font-weight-normal mt-0 mb-2">Treatment Plan</h4>
									<h5 class="mb-0 font-weight-normal text-success">{{examinations.treatment_plan}}</h5>
								</template>
							</b-card-body>
						</b-card>
							<!--end treatment plan-->
						<b-row>
							<b-col class="py-0" sm=12>
								<b-card>
									<b-card-body>
										<template>
											<img style="width: 7rem;" class="float-right" src="~assets/images/ex/skeletal.svg" alt />
											<h4 class="font-weight-normal mt-0 mb-2">Skeletal Class</h4>
											<h5 class="mb-0 font-weight-normal text-success">{{examinations.skeletal_class}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col class="py-0" sm=12>
								<b-card>
									<b-card-body>
										<template>
											<img
											style="width: 7rem;"
											class="float-right"
											src="~assets/images/ex/nasolabial-angle.svg"
											alt
											/>
											<h4 class="font-weight-normal mt-0 mb-2">Nasolabial Angle</h4>
											<h5 class="mb-0 font-weight-normal text-success">{{examinations.nasolabial_angle}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col class="py-0" sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Nasolabial Sulcus</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.nasolabial_sulcus}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Lip Competency</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.lip_competency}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Face Form</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.face_form}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Molar Class Left</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.molar_class_left}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Molar Class Left</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.molar_class_right}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Midline Upper</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.midline_upper}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Midline Lower</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.midline_lower}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Overjet</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.overjet}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Oral Hygiene</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.oral_hygiene}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Treated Arch</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.treated_arch}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Treated Arch</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.treated_arch}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-2">Slot</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.slot}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-4">Bracket System</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.bracket_system}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-4">Extraction Upper</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.extraction_upper}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card>
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-4">Extraction Lower</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.extraction_lower}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
							<b-col sm=12>
								<b-card class="p-0">
									<b-card-body>
										<template>
											<span class="float-right text-muted font-weight-normal">Normal / CLASS I</span>
										<h4 class="font-weight-normal mt-0 mb-4">Anchorage Upper</h4>
										<h5 class="mb-0 font-weight-normal text-success">{{examinations.anchorage_upper}}</h5>
										</template>
									</b-card-body>
								</b-card>
							</b-col>
						</b-row>
						<!--end row-->
					</b-col>
					<!--end col-->
				</b-row>
				<!--end row-->
			</b-col>
			<!--end col-->
		</b-row>
		<!--end row-->
	</div>
	<!--end general detail-->
</template>

<script>
export default {
	props: ["examinations"],
};
</script>