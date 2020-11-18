import Vue from "vue";

export const choices = Vue.observable({
    DOCTOR_CHOICES: [{
        value: 1,
        text: "Handren Ameer Kurda",
        selected: true
    }],
    GENDER: [{
            value: null,
            text: 'Please select an option'
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
    CLASS_CHOICES: [{
            value: null,
            text: 'Select...'
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

    NASOLABIAL_ANGLE: [{
            value: null,
            text: 'Select...'
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

    NASOLABIAL_SULCUS: [{
            value: null,
            text: 'Select...'
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
            text: 'Select...'
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
            text: 'Select...'
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
            text: 'Select...'
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
            text: 'Select...'
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

    TREATED_ARCH: [{
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
            text: 'Select...'
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
        },
    ],
});