//
//  FixedData.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/24/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

//"Beyoncé"       "user1"
//"Jaden Smith"   "user2"
//"Sky Ferreira"  "user3"
//"Liam Payne"    "user4"
//"Zendaya"       "user5"
//"Martin Garrix" "user6"
//"Sam Smith"     "user7"
//"Lorde"         "user8"
//"Charlie Puth"  "user9"

struct FixedData {
    static let newFeedData = [
        TNPostInfoModel(userId: "123",
                        username: "Beyoncé",
                        eduClass: "12A1",
                        timePosted: "12:10",
                        userAvatar: "user1",
                        content: "Ngày hôm qua, 23/7 là ngày kỉ niệm 39 năm ngày người Việt Nam đầu tiên được bay vào vũ trụ. Ông là ai?",
                        image: ["post1"],
                        viewCount: 18,
                        emotion: [
                          TNEmotionModel(emote: "ic_like", userName: "Jaden Smith", userAvatar: "user2"),
                          TNEmotionModel(emote: "ic_heart", userName: "Sky Ferreira", userAvatar: "user3"),
                          TNEmotionModel(emote: "ic_haha", userName: "Zendaya", userAvatar: "user5"),
                          TNEmotionModel(emote: "ic_like", userName: "Lorde", userAvatar: "user8")],
                        comment: [
                          TNCommentModel(commentUser:
                              TNCommentGeneralModel(avatar: UIImage(named: "user2"),
                                                    name: "Jaden Smith",
                                                    time: "12:11",
                                                    content: "Tưởng đầu tiên là chú cuội với chị Hằng mà:)",
                                                    isAnswer: true), answer: [
                                                        TNCommentGeneralModel(avatar: UIImage(named: "user3"), name: "Sky Ferreira", time: "12:12", content: "và sau ngần ấy năm chưa có ai theo đc bước chân của chu Tuân.", isAnswer: false)])]),
        TNPostInfoModel(userId: "123",
                        username: "Charlie Puth",
                        eduClass: "12A2",
                        timePosted: "11:50",
                        userAvatar: "user9",
                        content: "Ngày hôm qua, 23/7 là ngày kỉ niệm 39 năm ngày người Việt Nam đầu tiên được bay vào vũ trụ. Ông là ai?",
                        image: ["post1"],
                        viewCount: 18,
                        emotion: [
                            TNEmotionModel(emote: "ic_like", userName: "Jaden Smith", userAvatar: "user2"),
                            TNEmotionModel(emote: "ic_heart", userName: "Sky Ferreira", userAvatar: "user3"),
                            TNEmotionModel(emote: "ic_haha", userName: "Zendaya", userAvatar: "user5"),
                            TNEmotionModel(emote: "ic_like", userName: "Lorde", userAvatar: "user8")],
                        comment: [
                            TNCommentModel(commentUser:
                                TNCommentGeneralModel(avatar: UIImage(named: "user2"),
                                                      name: "Jaden Smith",
                                                      time: "12:11",
                                                      content: "Tưởng đầu tiên là chú cuội với chị Hằng mà:)",
                                                      isAnswer: true), answer: [
                                                        TNCommentGeneralModel(avatar: UIImage(named: "user9"), name: "Charlie Puth", time: "12:12", content: "và sau ngần ấy năm chưa có ai theo đc bước chân của chu Tuân.", isAnswer: false)])]),
        TNPostInfoModel(userId: "123",
                        username: "Beyoncé",
                        eduClass: "12A1",
                        timePosted: "12:10",
                        userAvatar: "user1",
                        content: "Đợt nắng nóng thứ 2 ở Tây và Bắc Âu liên tiếp phá vỡ các kỷ lục về nhiệt độ, có nguy cơ làm trầm trọng hơn tình trạng hạn hán hiện nay.",
                        image: ["post2"],
                        viewCount: 18,
                        emotion: [
                            TNEmotionModel(emote: "ic_like", userName: "Jaden Smith", userAvatar: "user2"),
                            TNEmotionModel(emote: "ic_heart", userName: "Sky Ferreira", userAvatar: "user3"),
                            TNEmotionModel(emote: "ic_haha", userName: "Zendaya", userAvatar: "user5"),
                            TNEmotionModel(emote: "ic_like", userName: "Lorde", userAvatar: "user8")],
                        comment: [
                            TNCommentModel(commentUser:
                                TNCommentGeneralModel(avatar: UIImage(named: "user2"),
                                                      name: "Jaden Smith",
                                                      time: "12:11",
                                                      content: "Quê mình cứ mùa hè khi mô mà không 40 - 41 độ. Nên để cho mấy ông bà châu Âu cảm nhận nó thêm chút",
                                                      isAnswer: true), answer: [
                                                        TNCommentGeneralModel(avatar: UIImage(named: "user3"), name: "Sky Ferreira", time: "12:12", content: "Như thế mà có gió lào như quê choa nữa thì ok luôn hihi", isAnswer: false)])]),
        TNPostInfoModel(userId: "123",
                        username: "Beyoncé",
                        eduClass: "12A1",
                        timePosted: "12:10",
                        userAvatar: "user1",
                        content: "Ngày hôm qua, 23/7 là ngày kỉ niệm 39 năm ngày người Việt Nam đầu tiên được bay vào vũ trụ. Ông là ai?",
                        image: ["post1"],
                        viewCount: 18,
                        emotion: [
                            TNEmotionModel(emote: "ic_like", userName: "Jaden Smith", userAvatar: "user2"),
                            TNEmotionModel(emote: "ic_heart", userName: "Sky Ferreira", userAvatar: "user3"),
                            TNEmotionModel(emote: "ic_haha", userName: "Zendaya", userAvatar: "user5"),
                            TNEmotionModel(emote: "ic_like", userName: "Lorde", userAvatar: "user8")],
                        comment: [
                            TNCommentModel(commentUser:
                                TNCommentGeneralModel(avatar: UIImage(named: "user2"),
                                                      name: "Jaden Smith",
                                                      time: "12:11",
                                                      content: "Tưởng đầu tiên là chú cuội với chị Hằng mà:)",
                                                      isAnswer: true), answer: [
                                                        TNCommentGeneralModel(avatar: UIImage(named: "user3"), name: "Sky Ferreira", time: "12:12", content: "và sau ngần ấy năm chưa có ai theo đc bước chân của chu Tuân.", isAnswer: false)])]),
        TNPostInfoModel(userId: "123",
                        username: "Beyoncé",
                        eduClass: "12A1",
                        timePosted: "12:10",
                        userAvatar: "user1",
                        content: "Ngày hôm qua, 23/7 là ngày kỉ niệm 39 năm ngày người Việt Nam đầu tiên được bay vào vũ trụ. Ông là ai?",
                        image: ["post1"],
                        viewCount: 18,
                        emotion: [
                            TNEmotionModel(emote: "ic_like", userName: "Jaden Smith", userAvatar: "user2"),
                            TNEmotionModel(emote: "ic_heart", userName: "Sky Ferreira", userAvatar: "user3"),
                            TNEmotionModel(emote: "ic_haha", userName: "Zendaya", userAvatar: "user5"),
                            TNEmotionModel(emote: "ic_like", userName: "Lorde", userAvatar: "user8")],
                        comment: [
                            TNCommentModel(commentUser:
                                TNCommentGeneralModel(avatar: UIImage(named: "user2"),
                                                      name: "Jaden Smith",
                                                      time: "12:11",
                                                      content: "Tưởng đầu tiên là chú cuội với chị Hằng mà:)",
                                                      isAnswer: true), answer: [
                                                        TNCommentGeneralModel(avatar: UIImage(named: "user3"), name: "Sky Ferreira", time: "12:12", content: "và sau ngần ấy năm chưa có ai theo đc bước chân của chu Tuân.", isAnswer: false)])])
    ]
}
