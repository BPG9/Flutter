

class QueryBackend {
  static String allObjects(String token) {
    return """query{
      allObjects(token: "$token"){
        additionalInformation
        artType
        category
        creator
        description
        interdisciplinaryContext
        location
        material
        objectId
        size_
        subCategory
        timeRange
        title
        year
        picture {
          id
        } 
      }
    } """;
  }

  static String tourSearchId(String token, String searchId) {
    return """query{
      tourSearchId(token: "$token", searchId: "$searchId")
    }""";
  }

  static String getTour(String token, String tourId) {
    return """query{
      tour(token: "$token", tourId: "$tourId"){
        lastEdit
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }

  static String checkpointTour(String token, String tourId) {
    return """query{
      checkpointsTour(token: "$token", tourId: "$tourId"){
        ... on ObjectCheckpoint{
          id
          index
          museumObject{
            objectId
          }
          showText
          showDetails
          showPicture
        }
        ... on Checkpoint{
          id
          index
          text
        }
        ... on PictureCheckpoint{
          index
          id
          picture {
            id
          }
        }
        ... on Question{
          id
          index
          text
          question
        }
        ... on MCQuestion{
          index
          id
          question
          possibleAnswers
          correctAnswers
          maxChoices
        }
      }
    }""";
  }

  static String allPictures(String token) {
    return """ query{
      availableProfilePictures(token:"$token")
    } """;
  }

  static String userInfo(String token) {
    return """query{
      me(token: "$token"){
        id
        producer
        profilePicture {
          id
        }
        badgeProgress
        badges {
          id
          name
          cost
          description
        }
      }
    }""";
  }

  static String favTours(String token) {
    return """query{
      favouriteTours(token: "$token"){
        lastEdit
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }

  static String profilePic(String token, String username) {
    return """query{
      profilePicture(token: "$token", username: "$username")
    }""";
  }

  static String favStops(String token) {
    return """query{
      favouriteObjects(token: "$token"){
        objectId
      }
    }""";
  }

  static String featured(String token) {
    return """query{
      featured(token: "$token"){
        lastEdit
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        status
      }
    }""";
  }

  static created(String token) {
    return """query{
      ownedTours(token: "$token"){
        lastEdit
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }

  static String allBadges(String token) {
    return """query{
      availableBadges(token: "$token"){
        cost
        description
        id
        name
      }
    }""";
  }

  static String availProfile(String token) {
    return """query{
      availableProfilePictures(token: "$token")
    }""";
  }

  static String myProfilePic(String token) {
    return """query{
      myProfilePictures(token: "$token")
    }""";
  }

  static String questionId(String token, String tourId, int index) {
    return """query { 
      questionId(token: "$token", tourId: "$tourId", index: $index) 
    }""";
  }

  static String exportResult(String token, String tourId, String username) {
    return """query{
      exportAnswers(token: "$token", tourId: "$tourId", username: "$username")
    }""";
  }

  static String answersInTour(String token, String user, String tourId) {
    return """query{
      answersByUser(token: "$token", username: "$user", tourId: "$tourId") {
        ... on Answer {
          id
          question {
            index
            question
          }
          text: answer
        }
        ... on MCAnswer {
          id
          question {
            index
            question
          }
        answer
        }
      }
    }""";
  }

}
