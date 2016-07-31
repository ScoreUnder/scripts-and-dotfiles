// vim:ts=4:sw=4:et
{
    // tabbed split container with 2 children
    "border": "pixel",
    "floating": "auto_off",
    "layout": "tabbed",
    "percent": 1,
    "type": "con",
    "nodes": [
        {
            // splith split container with 2 children
            "border": "pixel",
            "floating": "auto_off",
            "layout": "splith",
            "percent": 0.5,
            "type": "con",
            "nodes": [
                {
                    "border": "pixel",
                    "floating": "auto_off",
                    "geometry": {
                       "height": 733,
                       "width": 232,
                       "x": 0,
                       "y": 16
                    },
                    "name": "Buddy List",
                    "percent": 0.2236328125,
                    "swallows": [
                       {
                       "class": "^Pidgin$",
                       "instance": "^Pidgin$",
                       "title": "^Buddy\\ List$",
                       "window_role": "^buddy_list$"
                       }
                    ],
                    "type": "con"
                },
                {
                    "border": "pixel",
                    "floating": "auto_off",
                    "geometry": {
                       "height": 733,
                       "width": 790,
                       "x": 0,
                       "y": 0
                    },
                    "name": "Tendai Kembo",
                    "percent": 0.7763671875,
                    "swallows": [
                       {
                       "class": "^Pidgin$",
                       "instance": "^Pidgin$",
                       "window_role": "^conversation$"
                       }
                    ],
                    "type": "con"
                }
            ]
        },
        {
            // tabbed split container with 2 children
            "border": "pixel",
            "floating": "auto_off",
            "layout": "tabbed",
            "percent": 0.5,
            "type": "con",
            "nodes": [
                {
                    // splith split container with 2 children
                    "border": "pixel",
                    "current_border_width": 1,
                    "floating": "auto_off",
                    "layout": "splith",
                    "percent": 0.2861328125,
                    "type": "con",
                    "nodes": [
                        {
                            "border": "none",
                            "current_border_width": 0,
                            "floating": "auto_off",
                            "geometry": {
                               "height": 734,
                               "width": 1024,
                               "x": 0,
                               "y": 16
                            },
                            "name": "score_under - Skype™",
                            "percent": 0.265625,
                            "swallows": [
                               {
                               "class": "^Skype$",
                               "instance": "^skype$"
                               // "title": "^score_under\\ \\-\\ Skype™$"
                               }
                            ],
                            "type": "con"
                        },
                        {
                            // splitv split container with 2 children
                            "border": "pixel",
                            "floating": "auto_off",
                            "layout": "splitv",
                            "percent": 0.734375,
                            "type": "con",
                            "nodes": [
                                {
                                    "border": "none",
                                    "current_border_width": 0,
                                    "floating": "user_off",
                                    "geometry": {
                                       "height": 240,
                                       "width": 480,
                                       "x": 0,
                                       "y": 0
                                    },
                                    "name": "File Transfers",
                                    "percent": 0.306406685236769,
                                    "swallows": [
                                       {
                                       "class": "^Skype$",
                                       "instance": "^skype$",
                                       "title": "^File\\ Transfers$"
                                       }
                                    ],
                                    "type": "con"
                                },
                                {
                                    "border": "none",
                                    "current_border_width": 0,
                                    "floating": "user_off",
                                    "geometry": {
                                       "height": 1046,
                                       "width": 1920,
                                       "x": 0,
                                       "y": 0
                                    },
                                    "name": "Skype - File Manager",
                                    "percent": 0.693593314763231,
                                    "swallows": [
                                       {
                                       "class": "^Thunar$",
                                       "instance": "^thunar$",
                                       "title": "^Skype\\ \\-\\ File\\ Manager$"
                                       }
                                    ],
                                    "type": "con"
                                }
                            ]
                        }
                    ]
                },
                {
                    "border": "pixel",
                    "floating": "auto_off",
                    "geometry": {
                       "height": 734,
                       "width": 1024,
                       "x": 0,
                       "y": 16
                    },
                    "name": "12bob50 - Skype™",
                    "percent": 0.7138671875,
                    "swallows": [
                       {
                       "class": "^Skype$",
                       "instance": "^skype$",
                       "window_role": "^ConversationsWindow$"
                       }
                    ],
                    "type": "con"
                }
            ]
        }
    ]
}

