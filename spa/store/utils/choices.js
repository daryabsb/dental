import Vue from "vue";

export const choices = Vue.observable({
  DOCTOR_CHOICES: [
    {
      value: 1,
      text: "Handren Ameer Kurda",
      selected: true
    }
  ],
  GENDER: [
    {
      value: null,
      text: "Please select an option"
    },
    {
      value: "male",
      text: "MALE"
    },
    {
      value: "female",
      text: "FEMALE"
    }
  ],
  CLASS_CHOICES: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "class1",
      text: "CLASS I"
    },
    {
      value: "class2",
      text: "CLASS II"
    },
    {
      value: "class3",
      text: "CLASS III"
    }
  ],

  NASOLABIAL_ANGLE: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "normal",
      text: "NORMAL"
    },
    {
      value: "acute",
      text: "ACUTE"
    },
    {
      value: "obtuse",
      text: "OBTUCE"
    }
  ],

  NASOLABIAL_SULCUS: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "normal",
      text: "NORMAL"
    },
    {
      value: "deep",
      text: "DEEP"
    }
  ],

  LIP_COMPETENCY: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "competent",
      text: "COMPETENT"
    },
    {
      value: "incompetent",
      text: "INCOMPETENT"
    },
    {
      value: "partially_competent",
      text: "PARTIALLY COMPETENT"
    }
  ],

  FACE_FORM: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "dolichocephalic",
      text: "DOLICHOCEPHALIC"
    },
    {
      value: "mesocephalic",
      text: "MESOCEPHALIC"
    },
    {
      value: "brachycephalic",
      text: "BRACHYCEPHALIC"
    }
  ],

  MIDLINE_CHOICES: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "coincidence",
      text: "COINIDENCE"
    },
    {
      value: "deviated_to_left",
      text: "DEVIATED TO LEFT"
    },
    {
      value: "deviated_to_right",
      text: "DEVIATED TO RIGHT"
    }
  ],
  ORAL_HYGIENE: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "good",
      text: "GOOD"
    },
    {
      value: "fair",
      text: "FAIR"
    },
    {
      value: "bad",
      text: "BAD"
    }
  ],

  TREATED_ARCH: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "max",
      text: "MAX"
    },
    {
      value: "mand",
      text: "MAND"
    }
  ],
  MEDICALS: [
    {
      value: null,
      text: "Select..."
    },
    {
      value: "95",
      text: "EXCELENT"
    },
    {
      value: "75",
      text: "GOOD"
    },
    {
      value: "50",
      text: "FAIR"
    },
    {
      value: "25",
      text: "BAD"
    },
    {
      value: "10",
      text: "WORST"
    }
  ],
  patient: {
    name: "",
    doctor: 1,
    dob: "",
    gender: null,
    description: "",
    phone: "",
    email: "",
    status: true,

    examinations: {
      skeletal_class: null,
      nasolabial_angle: null,
      nasolabial_sulcus: null,
      lip_competency: null,
      face_form: null,
      molar_class_left: null,
      molar_class_right: null,
      midline_upper: null,
      midline_lower: null,
      overjet: "",
      oral_hygiene: null,
      treatment_plan: "",
      slot: "",
      treated_arch: null,
      bracket_system: null,
      extraction_upper: null,
      extraction_lower: null,
      anchorage_upper: null,
      tongue_size: "",
      habit: ""
    },
    medicals: {
      physical_restrictions: "75",
      sinus_infections: "75",
      diabetes: "75",
      heart_problem: "75",
      kidney_illness: "75",
      emotional_difficulties: "75",
      other_diseasses: ""
    }
  },
  treatmentPlans: [
    {
      value: "Bonding",
      text:
        "Bonding is a treatment that can be used to repair teeth that are decayed, chipped, fractured or discoloured or to reduce gaps between teeth. For this value, a dentist mixes composite resin — a type of plastic — into a paste, then tints the mixture to whiten or match the color of your teeth. Several layers of resin are applied to each tooth. Each layer is hardened under an ultraviolet light or laser. Final steps include shaping and polishing the resin material so the finished tooth looks natural and smooth. Bonding can also be used to build up older teeth to make them appear younger. Bonding is an option for people of all ages, including children, as the resin can be replaced as teeth grow."
    },
    {
      value: "Braces",
      text:
        "A dental brace is a device used to correct the alignment of teeth and bite-related problems (including underbite, overbite, etc.). Braces straighten teeth by exerting steady pressure on the teeth. Learn more about braces and other orthodontic treatments here."
    },
    {
      value: "Bridges and Implants",
      text:
        "Bridges and implants are two ways to replace a missing tooth or teeth. Bridges are false teeth anchored in place by neighbouring teeth. The bridge consists of two crowns on the anchoring teeth along with the false tooth in the centre. Dental implants are artificial roots used to support replacement teeth. Learn more on our Bridges & Implants page."
    },
    {
      value: "Crowns and Caps",
      text:
        "A crown or cap is a cover that fits over a tooth that has been damaged by decay, broken, badly stained or mis-shaped. It is prepared by your dentist, and usually requires more than one visit to complete. A crown can be made of acrylic, metal, porcelain, or porcelain bonded to metal. All-porcelain crowns look more like your natural teeth, and therefore are usually used for front teeth, while porcelain bonded to metal is stronger and better for crowns in the back of the mouth. Sometimes all-metal crowns are used for back teeth because of the metal’s strength. To prepare your tooth for a crown, the tooth is first frozen with anesthesia, and then filed down so the cap can fit over it. An impression of the teeth and gums is made, and a temporary cap is fitted over the tooth until the permanent crown is ready. On your next visit, the dentist will remove the temporary cap and cement the crown onto the tooth. The crown will closely match the colour and shape of your natural teeth."
    },
    {
      value: "Extractions",
      text:
        "A severely damaged tooth may need to be extracted. Permanent teeth may also need to be removed for orthodontic treatment."
    },
    {
      value: "Dentures",
      text:
        "Dentures are prosthetic devices replacing lost teeth. There are two types of dentures – partial and full. Full dentures are often referred to as “false teeth”. Learn more on our Dentures page."
    },
    {
      value: "Fillings and Repairs",
      text:
        "Dental fillings and repairs use restorative materials used to repair teeth which have been compromised due to cavities or trauma. More information on fillings can be found here. "
    },
    {
      value: "Gum Surgery",
      text:
        "Periodontal or gum disease is an infection that affects the gums and jaw bone, which can lead to a loss of gum and teeth. There are two major stages — gingivitis and periodontitis. Gingivitis is the milder and reversible form; periodontal disease is often more severe. In some cases, gum surgery will be required to reverse the effect of the disease."
    },
    {
      value: "Oral Cancer Examination",
      text:
        "Oral cancer starts in the cells of the mouth, tongue or throat. Oral cancer screening is usually a routine part of a dental examination. In this exam, your dentist will feel for lumps or irregular tissue changes in your neck, head, face, and inside your mouth. Your dentist will also look for sores or discolored tissue in your mouth."
    },
    {
      value: "Root Canals",
      text:
        "Root canals treat diseases or absessed teeth. Once a tooth is injured, cracked or decayed, it is necessary to open the tooth and clean out the infected tissue in the centre. This space is then filled and the opening sealed. Keeping your tooth helps to prevent your other teeth from drifting out of line and causing jaw problems. Saving a natural tooth avoids having to replace it with an artificial tooth. Talk to your dentist or endodontist about any concerns or questions you may have."
    },

    {
      value: "Sealants",
      text:
        "Dental sealants, usually applied to the chewing surface of teeth, act as a barrier against decay-causing bacteria. Most often, the sealants are applied to the back teeth, e.g., premolars and molars."
    },
    {
      value: "Teeth Whitening",
      text:
        "Teeth naturally darken with age, however staining may be caused by various foods and beverages such as coffee, tea and berries, some drugs such as tetracycline, smoking, or a trauma to a tooth. There are various teeth whitening options available, including in-office and at-home bleaching."
    },
    {
      value: "Veneers",
      text:
        "Veneers are strong, thin pieces of porcelain that are bonded to the teeth. They are used to repair chipped, decayed or stained teeth and may help in closing gaps between teeth. With a bit of contouring, veneers may also correct slightly crowded or overlapping teeth. If your teeth have discoloured with age, a veneer may improve their appearance. Veneers can also be used for cosmetic reasons instead of crowns, which are more often used for badly damaged or decayed teeth. The tooth enamel needs to be ground down slightly in order to accommodate the veneer. Veneer preparations frequently require the use of local anesthetic and, depending on colour and shade, may take more than one appointment to complete."
    }
  ]
});

export const mutateChoices = {
  updateName(value) {
    console.log(value);
    choices.patient.name = value;
  }
};
