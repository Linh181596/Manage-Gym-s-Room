USE [GymCenterManagement]

GO



IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xin chào')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xin chào',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chào')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chào',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chào bạn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chào bạn',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hello')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hello',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hey')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hey',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Alo')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Alo',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ai không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ai không?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chatbot ơi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chatbot ơi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bot ơi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bot ơi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Trợ lý ơi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Trợ lý ơi',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn là ai?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn làm được gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn làm được gì?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn hỗ trợ được gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn hỗ trợ được gì?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi cần tư vấn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi cần tư vấn',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có người hỗ trợ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có người hỗ trợ không?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn hỏi thông tin phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn hỏi thông tin phòng gym',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bạn có thể giúp tôi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bạn có thể giúp tôi không?',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cho tôi hỏi chút')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cho tôi hỏi chút',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mình cần hỏi về phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mình cần hỏi về phòng gym',
    N'Xin chào! Tôi là trợ lý hỗ trợ khách hàng của phòng gym. Bạn có thể hỏi về đăng ký hội viên, gói tập, thanh toán, hóa đơn, PT, thiết bị, cơ sở vật chất, giờ mở cửa hoặc thông tin liên hệ.',
    N'Greeting',
    N'xin chào, chao, hello, hi, hey, alo, chatbot, bot, trợ lý, tro ly, tư vấn, tu van, hỗ trợ, ho tro, hỏi thông tin, gym support',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao để đăng ký hội viên?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao để đăng ký hội viên?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký hội viên như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký hội viên như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Muốn đăng ký tập gym thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Muốn đăng ký tập gym thì làm sao?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tham gia phòng gym thì làm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tham gia phòng gym thì làm gì?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký trực tiếp được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký trực tiếp được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có đăng ký tại quầy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có đăng ký tại quầy không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có đăng ký qua website không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có đăng ký qua website không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có đăng ký online không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có đăng ký online không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có thể tạo tài khoản hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có thể tạo tài khoản hội viên ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mở tài khoản hội viên như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mở tài khoản hội viên như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạo tài khoản mới thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạo tài khoản mới thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi chưa có tài khoản thì đăng ký ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi chưa có tài khoản thì đăng ký ra sao?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký cần thông tin gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký cần thông tin gì?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký cần chuẩn bị gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký cần chuẩn bị gì?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cần những giấy tờ gì để đăng ký?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cần những giấy tờ gì để đăng ký?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cần CCCD không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cần CCCD không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần căn cước công dân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần căn cước công dân không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần số điện thoại khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần số điện thoại khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần email khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần email khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Email đã dùng rồi có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Email đã dùng rồi có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số điện thoại đã dùng rồi có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số điện thoại đã dùng rồi có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao nhiêu tuổi được đăng ký?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao nhiêu tuổi được đăng ký?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Học sinh có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Học sinh có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sinh viên có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sinh viên có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người dưới 18 tuổi có đăng ký được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người dưới 18 tuổi có đăng ký được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao lâu thì đăng ký xong?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao lâu thì đăng ký xong?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký mất bao lâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký mất bao lâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký xong có tập ngay được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký xong có tập ngay được không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khi nào tài khoản được kích hoạt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khi nào tài khoản được kích hoạt?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mua gói ngay khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mua gói ngay khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký tài khoản có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký tài khoản có mất phí không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạo tài khoản có cần thanh toán không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạo tài khoản có cần thanh toán không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần tài khoản để mua gói không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần tài khoản để mua gói không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có thể nhờ lễ tân đăng ký giúp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có thể nhờ lễ tân đăng ký giúp không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người mới đến lần đầu đăng ký thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người mới đến lần đầu đăng ký thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đăng ký trước rồi thanh toán sau không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đăng ký trước rồi thanh toán sau không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký hội viên mới có được tư vấn gói tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký hội viên mới có được tư vấn gói tập không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn mở thẻ hội viên')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn mở thẻ hội viên',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm thẻ hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm thẻ hội viên ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký member như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký member như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Join gym như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Join gym như thế nào?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Membership registration ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Membership registration ở đâu?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần xác thực email khi đăng ký không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần xác thực email khi đăng ký không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký xong có nhận thông báo không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký xong có nhận thông báo không?',
    N'Bạn có thể tạo tài khoản hội viên trên website hoặc đăng ký trực tiếp tại quầy lễ tân. Khi đăng ký, bạn nên chuẩn bị họ tên, email và số điện thoại để nhân viên hỗ trợ kích hoạt tài khoản và tư vấn gói tập phù hợp.',
    N'Membership Registration',
    N'đăng ký, dang ky, đăng ký hội viên, dang ky hoi vien, member, membership, join gym, tham gia, mở tài khoản, mo tai khoan, tạo tài khoản, tao tai khoan, đăng ký phòng gym, đăng ký online, lễ tân, le tan',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có những gói tập nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có những gói tập nào?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có gói tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có gói tập gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Danh sách gói tập hiện có?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Danh sách gói tập hiện có?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bao nhiêu gói gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bao nhiêu gói gym?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Các loại gói hội viên là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Các loại gói hội viên là gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Membership package gồm những gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Membership package gồm những gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Package hiện có là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Package hiện có là gì?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cơ bản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cơ bản không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cao cấp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cao cấp không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói 1 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói 1 tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói 3 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói 3 tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói ngắn hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói ngắn hạn không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói dài hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói dài hạn không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói năm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói năm không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói 6 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói 6 tháng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói theo ngày không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói theo ngày không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tập thử không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tập thử không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cho người mới không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cho người mới không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cho sinh viên không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cho sinh viên không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói gia đình không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói gia đình không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cặp đôi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cặp đôi không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tập buổi sáng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tập buổi sáng không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói tập buổi tối không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói tập buổi tối không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói cuối tuần không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói cuối tuần không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói không giới hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói không giới hạn không?',
    N'Hiện hệ thống ghi nhận 2 gói Gym đang hoạt động: Gói Gym Cơ bản 1 Tháng giá 300.000đ và Gói Gym Cao cấp 3 Tháng giá 800.000đ. Các gói khác nếu có chính sách mới, bạn vui lòng liên hệ lễ tân để xác nhận.',
    N'Membership Package',
    N'gói tập, goi tap, gói gym, goi gym, membership package, package, gói tháng, goi thang, gói năm, goi nam, basic, premium, 1 tháng, 3 tháng, giá gói, gia goi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá gói tập bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá gói tập bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá gói gym là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá gói gym là bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao nhiêu tiền một gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao nhiêu tiền một gói tập?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chi phí tập gym là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chi phí tập gym là bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảng giá gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảng giá gói tập?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Price gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Price gói tập?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cost membership?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cost membership?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tập giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tập giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập gym hết bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập gym hết bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mua gói tập bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mua gói tập bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 1 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 1 tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Gym Cơ bản 1 Tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Gym Cơ bản 1 Tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói cơ bản bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói cơ bản bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 300 nghìn là gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 300 nghìn là gói nào?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 3 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 3 tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Gym Cao cấp 3 Tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Gym Cao cấp 3 Tháng giá bao nhiêu?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói cao cấp bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói cao cấp bao nhiêu tiền?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói 800 nghìn là gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói 800 nghìn là gói nào?',
    N'Gói Gym Cơ bản 1 Tháng có giá 300.000đ. Gói Gym Cao cấp 3 Tháng có giá 800.000đ.',
    N'Membership Package',
    N'giá, gia, bao nhiêu tiền, bao nhieu tien, chi phí, chi phi, price, cost, membership price, gói tập, goi tap, package, 300000, 800000, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào rẻ nhất?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào rẻ nhất?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tập rẻ nhất là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tập rẻ nhất là gì?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tiết kiệm nhất là gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tiết kiệm nhất là gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói thấp tiền nhất?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói thấp tiền nhất?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào giá thấp nhất?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào giá thấp nhất?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào phù hợp cho người mới?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào phù hợp cho người mới?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người mới nên mua gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người mới nên mua gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nên chọn gói 1 tháng hay 3 tháng?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nên chọn gói 1 tháng hay 3 tháng?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói nào phù hợp với tôi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói nào phù hợp với tôi?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi mới tập gym nên chọn gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi mới tập gym nên chọn gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập thử thì nên mua gói nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập thử thì nên mua gói nào?',
    N'Gói 1 tháng phù hợp nếu bạn mới bắt đầu hoặc muốn trải nghiệm. Gói 3 tháng phù hợp nếu bạn muốn tập đều hơn và tiết kiệm hơn so với mua từng tháng.',
    N'Membership Package',
    N'gói rẻ nhất, goi re nhat, tiết kiệm, tiet kiem, người mới, nguoi moi, tư vấn gói, tu van goi, phù hợp, phu hop, 1 tháng, 3 tháng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn gói như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn gói như thế nào?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao gia hạn gói tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao gia hạn gói tập?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn gia hạn gói gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn gia hạn gói gym',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói sắp hết hạn thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói sắp hết hạn thì làm sao?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói hết hạn có gia hạn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói hết hạn có gia hạn được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn ở đâu?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn online được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn online được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn tại quầy được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn tại quầy được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn trước ngày hết hạn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn trước ngày hết hạn được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hết hạn rồi có gia hạn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hết hạn rồi có gia hạn được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn gói 1 tháng thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn gói 1 tháng thế nào?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn gói 3 tháng thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn gói 3 tháng thế nào?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần thanh toán khi gia hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần thanh toán khi gia hạn không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn xong có tập ngay được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn xong có tập ngay được không?',
    N'Bạn có thể gia hạn gói tập tại quầy lễ tân. Nhân viên sẽ kiểm tra gói hiện tại, tư vấn gói phù hợp, tạo hóa đơn và ghi nhận thanh toán.',
    N'Membership Management',
    N'gia hạn, gia han, renew, renewal, hết hạn, het han, sắp hết hạn, sap het han, kéo dài gói, keo dai goi, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hết hạn khi nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hết hạn khi nào?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao biết gói còn hạn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao biết gói còn hạn không?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kiểm tra ngày hết hạn ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kiểm tra ngày hết hạn ở đâu?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói của tôi còn bao lâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói của tôi còn bao lâu?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói tập còn mấy ngày?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói tập còn mấy ngày?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn xem hạn gói tập')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn xem hạn gói tập',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Membership expiration xem ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Membership expiration xem ở đâu?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ngày hết hạn gói tập là ngày nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ngày hết hạn gói tập là ngày nào?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm sao kiểm tra trạng thái gói?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm sao kiểm tra trạng thái gói?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Active nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Active nghĩa là gì?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói Expired nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói Expired nghĩa là gì?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tại sao gói của tôi hết hạn?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tại sao gói của tôi hết hạn?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói hết hạn có vào tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói hết hạn có vào tập được không?',
    N'Bạn đăng nhập và vào mục Thẻ & Gói tập để xem ngày bắt đầu, ngày hết hạn và trạng thái gói. Active là còn hiệu lực, Expired là đã hết hạn.',
    N'Membership Management',
    N'hết hạn, het han, expiration, ngày hết hạn, ngay het han, gói còn hạn, goi con han, Active, Expired, trạng thái gói, thẻ và gói tập',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi gói tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi gói tập được không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi gói')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi gói',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đổi từ gói 1 tháng sang 3 tháng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đổi từ gói 1 tháng sang 3 tháng không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đổi từ gói 3 tháng sang gói khác không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đổi từ gói 3 tháng sang gói khác không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nâng cấp gói được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nâng cấp gói được không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn nâng cấp gói tập')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn nâng cấp gói tập',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể nâng cấp lên gói cao cấp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể nâng cấp lên gói cao cấp không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể hạ gói không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể hạ gói không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi package như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi package như thế nào?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Upgrade membership ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Upgrade membership ra sao?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thay đổi gói đang dùng được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thay đổi gói đang dùng được không?',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đang dùng gói này muốn đổi gói khác')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đang dùng gói này muốn đổi gói khác',
    N'Nếu muốn đổi hoặc nâng cấp gói, bạn vui lòng liên hệ quầy lễ tân để nhân viên kiểm tra gói hiện tại và tư vấn cách xử lý phù hợp.',
    N'Membership Management',
    N'đổi gói, doi goi, nâng cấp, nang cap, upgrade, downgrade, change package, chuyển gói, chuyen goi, gói hiện tại',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy gói tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy gói tập được không?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn hủy gói')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn hủy gói',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không tập nữa có hủy gói được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không tập nữa có hủy gói được không?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy membership như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy membership như thế nào?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cancel package ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cancel package ra sao?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảo lưu gói được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảo lưu gói được không?',
    N'Các yêu cầu hủy gói, bảo lưu hoặc chuyển nhượng cần được kiểm tra theo tình trạng gói và chính sách hiện tại. Riêng chuyển nhượng thường cần gói còn hiệu lực và còn ít nhất 1 ngày sử dụng. Bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ.',
    N'Membership Management',
    N'hủy gói, huy goi, cancel, bảo lưu, bao luu, đóng băng, dong bang, frozen, tạm dừng, tam dung, chuyển nhượng, chuyen nhuong, transfer package, sang tên',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán thế nào?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi thanh toán gói tập ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi thanh toán gói tập ở đâu?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán tại quầy được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán tại quầy được không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đóng tiền ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đóng tiền ở đâu?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Trả tiền gói tập như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Trả tiền gói tập như thế nào?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán tiền mặt không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán tiền mặt không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có trả bằng cash không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có trả bằng cash không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể trả tiền mặt không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể trả tiền mặt không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán xong bao lâu cập nhật?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán xong bao lâu cập nhật?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán rồi có tập ngay được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán rồi có tập ngay được không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần thanh toán trước khi tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần thanh toán trước khi tập không?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký xong thanh toán ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký xong thanh toán ra sao?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gia hạn xong thanh toán thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gia hạn xong thanh toán thế nào?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán dịch vụ PT ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán dịch vụ PT ở đâu?',
    N'Bạn có thể thanh toán tại quầy lễ tân. Sau khi thanh toán, nhân viên sẽ ghi nhận hóa đơn trên hệ thống để cập nhật trạng thái giao dịch.',
    N'Payment',
    N'thanh toán, thanh toan, payment, pay, trả tiền, tra tien, đóng tiền, dong tien, tiền mặt, tien mat, cash, quầy lễ tân',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chuyển khoản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chuyển khoản không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng chuyển khoản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng chuyển khoản không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có banking không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có banking không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bank transfer không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bank transfer không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có số tài khoản ngân hàng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có số tài khoản ngân hàng không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có QR không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có QR không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán QR không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán QR không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quét mã QR không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quét mã QR không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mã QR chuyển khoản không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mã QR chuyển khoản không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có QR Pay không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có QR Pay không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán online không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán online không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán qua app không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán qua app không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Momo không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Momo không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có VNPay không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có VNPay không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ví điện tử không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ví điện tử không?',
    N'Hệ thống hiện ưu tiên ghi nhận thanh toán tại quầy. Nếu bạn muốn chuyển khoản, QR hoặc thanh toán online, vui lòng liên hệ lễ tân để được xác nhận phương thức đang áp dụng.',
    N'Payment',
    N'chuyển khoản, chuyen khoan, bank transfer, banking, qr, mã qr, ma qr, online payment, momo, vnpay, ví điện tử, vi dien tu',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Visa không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Visa không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng Visa không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng Visa không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Mastercard không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Mastercard không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng Mastercard không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng Mastercard không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quẹt thẻ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quẹt thẻ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thanh toán bằng thẻ ngân hàng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thanh toán bằng thẻ ngân hàng không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thẻ tín dụng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thẻ tín dụng không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thẻ ghi nợ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thẻ ghi nợ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có card payment không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có card payment không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có POS không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có POS không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có trả góp không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có trả góp không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận thanh toán thẻ hoặc trả góp trong FAQ. Bạn vui lòng hỏi trực tiếp quầy lễ tân để được xác nhận phương thức thanh toán hiện có.',
    N'Payment',
    N'visa, mastercard, master card, thẻ ngân hàng, the ngan hang, credit card, debit card, POS, trả góp, tra gop, đặt cọc, dat coc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hóa đơn không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanh toán có hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanh toán có hóa đơn không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có nhận hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có nhận hóa đơn không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có biên lai không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có biên lai không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có receipt không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có receipt không?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem hóa đơn ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem hóa đơn ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn xem hóa đơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn xem hóa đơn',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem lịch sử hóa đơn thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem lịch sử hóa đơn thế nào?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn của tôi ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn của tôi ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Invoice detail xem ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Invoice detail xem ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn Pending nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn Pending nghĩa là gì?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn Paid nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn Paid nghĩa là gì?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn Cancelled nghĩa là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn Cancelled nghĩa là gì?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tại sao hóa đơn của tôi Pending?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tại sao hóa đơn của tôi Pending?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn đã thanh toán ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn đã thanh toán ở đâu?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn gói tập xem thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn gói tập xem thế nào?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn PT xem thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn PT xem thế nào?',
    N'Có. Khi giao dịch được ghi nhận, hệ thống sẽ lưu hóa đơn. Bạn có thể đăng nhập để xem giao dịch gần đây hoặc liên hệ quầy lễ tân để được hỗ trợ tra cứu hóa đơn.',
    N'Invoice',
    N'hóa đơn, hoa don, invoice, receipt, biên lai, bien lai, lịch sử thanh toán, lich su thanh toan, Pending, Paid, Cancelled',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'In hóa đơn được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'In hóa đơn được không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn in hóa đơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn in hóa đơn',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể in biên lai không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể in biên lai không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi cần bản in hóa đơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi cần bản in hóa đơn',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có xuất file hóa đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có xuất file hóa đơn không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hóa đơn VAT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hóa đơn VAT không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có xuất hóa đơn VAT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có xuất hóa đơn VAT không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hóa đơn đỏ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hóa đơn đỏ không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cần VAT thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cần VAT thì làm sao?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xuất hóa đơn công ty được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xuất hóa đơn công ty được không?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hóa đơn sai thông tin thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hóa đơn sai thông tin thì làm sao?',
    N'Nếu cần in hóa đơn, biên lai hoặc hỏi về hóa đơn VAT, bạn vui lòng liên hệ quầy lễ tân để được hỗ trợ theo dữ liệu giao dịch thực tế.',
    N'Invoice',
    N'in hóa đơn, in hoa don, print invoice, hóa đơn VAT, hoa don vat, hóa đơn đỏ, hoa don do, biên lai, receipt, sửa hóa đơn, mất hóa đơn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có PT không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có huấn luyện viên cá nhân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có huấn luyện viên cá nhân không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Personal Trainer không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Personal Trainer không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có coach không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có coach không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có trainer riêng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có trainer riêng không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thuê PT như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thuê PT như thế nào?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn thuê PT')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn thuê PT',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký PT ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký PT ở đâu?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Book PT như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Book PT như thế nào?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt lịch PT ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt lịch PT ra sao?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng ký PT cần điều kiện gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng ký PT cần điều kiện gì?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần gói Gym để thuê PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần gói Gym để thuê PT không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không có gói Gym thuê PT được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không có gói Gym thuê PT được không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hội viên mới có thuê PT được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hội viên mới có thuê PT được không?',
    N'Có. Phòng gym có dịch vụ PT. Bạn cần có tài khoản hội viên và gói Gym còn hiệu lực để đăng ký dịch vụ PT. Bạn có thể chọn PT, chọn gói dịch vụ và ngày bắt đầu mong muốn.',
    N'Personal Trainer',
    N'pt, personal trainer, coach, trainer, huấn luyện viên cá nhân, huan luyen vien ca nhan, thuê pt, thue pt, book pt, đăng ký pt, dang ky pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá PT bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá PT bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thuê PT bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thuê PT bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảng giá PT?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảng giá PT?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chi phí thuê PT?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chi phí thuê PT?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT price là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT price là bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá PT 1 tháng bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá PT 1 tháng bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 1 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 1 tháng giá bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT cơ bản bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT cơ bản bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT 12 buổi bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT 12 buổi bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá PT 3 tháng bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá PT 3 tháng bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 3 tháng giá bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 3 tháng giá bao nhiêu?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT cao cấp bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT cao cấp bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT 36 buổi bao nhiêu tiền?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT 36 buổi bao nhiêu tiền?',
    N'Giá PT tùy theo PT và gói. Gói PT 1 tháng hiện từ 999.000đ đến 1.500.000đ; gói PT 3 tháng hiện từ 2.700.000đ đến 4.200.000đ.',
    N'Personal Trainer',
    N'giá pt, gia pt, thuê pt bao nhiêu, thue pt bao nhieu, pt price, personal trainer price, 1 tháng, 3 tháng, 12 buổi, 36 buổi',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT có bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT có bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 1 tháng có mấy buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 1 tháng có mấy buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gói PT 3 tháng có mấy buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gói PT 3 tháng có mấy buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cơ bản có bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cơ bản có bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cao cấp có bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cao cấp có bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Một tháng PT tập bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Một tháng PT tập bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ba tháng PT tập bao nhiêu buổi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ba tháng PT tập bao nhiêu buổi?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số buổi tập với PT là bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số buổi tập với PT là bao nhiêu?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT package gồm bao nhiêu session?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT package gồm bao nhiêu session?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT sessions là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT sessions là gì?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói PT 12 buổi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói PT 12 buổi không?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gói PT 36 buổi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gói PT 36 buổi không?',
    N'Gói PT Cơ bản 1 Tháng gồm 12 buổi. Gói PT Cao cấp 3 Tháng gồm 36 buổi.',
    N'Personal Trainer',
    N'gói pt, goi pt, số buổi, so buoi, sessions, 12 buổi, 36 buổi, basic pt, premium pt, pt package',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT nào tốt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT nào tốt?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nên chọn PT nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nên chọn PT nào?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT nào phù hợp với tôi?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT nào phù hợp với tôi?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT giảm cân là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT giảm cân là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT tăng cơ là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT tăng cơ là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cardio là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cardio là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT yoga là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT yoga là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT boxing là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT boxing là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT dinh dưỡng là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT dinh dưỡng là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có PT phục hồi thể lực không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có PT phục hồi thể lực không?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cho người mới là ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cho người mới là ai?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT cho nữ có không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT cho nữ có không?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'PT nam có không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'PT nam có không?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể đổi PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể đổi PT không?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi huấn luyện viên')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi huấn luyện viên',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không hợp PT thì đổi được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không hợp PT thì đổi được không?',
    N'Bạn có thể chọn PT theo mục tiêu: Trần Minh Quân hỗ trợ quản lý cân nặng, Nguyễn Hoàng Nam hỗ trợ tăng cơ, Anh Khoa Cardio hỗ trợ cardio, Nga Yoga hỗ trợ yoga, Vũ Đức Long hỗ trợ boxing, Coach Huy DD hỗ trợ dinh dưỡng. Nếu muốn đổi PT, vui lòng liên hệ quầy lễ tân để được kiểm tra lịch và chính sách.',
    N'Personal Trainer',
    N'pt nào tốt, pt nao tot, chọn pt, chon pt, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, đổi pt, doi pt, hồ sơ pt',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có thiết bị gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có thiết bị gì?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có những máy tập nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có những máy tập nào?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị phòng gym gồm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị phòng gym gồm gì?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy chạy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy chạy không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy chạy bộ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy chạy bộ không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có treadmill không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có treadmill không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ghế tập ngực không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ghế tập ngực không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bench press không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bench press không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu cardio không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu cardio không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tập tạ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tập tạ không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy squat không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy squat không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có squat rack không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có squat rack không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có dumbbell không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có dumbbell không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tạ đơn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tạ đơn không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tạ tay không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tạ tay không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có barbell không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có barbell không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy tập chân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy tập chân không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy kéo xô không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy kéo xô không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy đạp xe không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy đạp xe không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy rowing không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy rowing không?',
    N'Dữ liệu hiện có ghi nhận Máy chạy bộ Matrix T50 tại Khu Cardio và Ghế tập ngực Bench Press tại Khu tập tạ tự do. Với các thiết bị khác, bạn vui lòng liên hệ quầy lễ tân để kiểm tra tình trạng hiện có.',
    N'Equipment',
    N'thiết bị, thiet bi, máy tập, may tap, equipment, treadmill, máy chạy bộ, bench press, ghế tập ngực, squat, dumbbell, tạ đơn, cardio, khu tập tạ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy bị hỏng thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy bị hỏng thì làm sao?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị hỏng báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị hỏng báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Báo hỏng thiết bị ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Báo hỏng thiết bị ở đâu?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy tập không hoạt động thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy tập không hoạt động thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy chạy bị lỗi thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy chạy bị lỗi thì làm sao?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị không an toàn thì làm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị không an toàn thì làm gì?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạ bị hỏng thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạ bị hỏng thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ghế tập bị hỏng thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ghế tập bị hỏng thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể báo sự cố thiết bị không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể báo sự cố thiết bị không?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Report máy hỏng ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Report máy hỏng ở đâu?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi thấy máy tập nguy hiểm')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi thấy máy tập nguy hiểm',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Máy tập cần bảo trì thì báo ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Máy tập cần bảo trì thì báo ai?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thiết bị bẩn thì phản ánh ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thiết bị bẩn thì phản ánh ở đâu?',
    N'Nếu thấy thiết bị hỏng, bẩn hoặc có dấu hiệu không an toàn, bạn vui lòng báo ngay cho nhân viên hoặc quầy lễ tân, nêu rõ tên thiết bị và vị trí để được xử lý.',
    N'Equipment',
    N'máy hỏng, may hong, thiết bị hỏng, thiet bi hong, báo hỏng, bao hong, report issue, equipment issue, không an toàn, bao tri, bảo trì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hướng dẫn sử dụng máy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hướng dẫn sử dụng máy không?',
    N'Nếu chưa biết sử dụng thiết bị, bạn nên hỏi nhân viên hoặc đăng ký PT để được hướng dẫn kỹ thuật an toàn, tránh chấn thương khi tập luyện.',
    N'Equipment',
    N'hướng dẫn sử dụng máy, huong dan su dung may, dùng thiết bị, dung thiet bi, an toàn, an toan, kỹ thuật, ky thuat, người mới, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không biết dùng máy thì hỏi ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không biết dùng máy thì hỏi ai?',
    N'Nếu chưa biết sử dụng thiết bị, bạn nên hỏi nhân viên hoặc đăng ký PT để được hướng dẫn kỹ thuật an toàn, tránh chấn thương khi tập luyện.',
    N'Equipment',
    N'hướng dẫn sử dụng máy, huong dan su dung may, dùng thiết bị, dung thiet bi, an toàn, an toan, kỹ thuật, ky thuat, người mới, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có phòng tắm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có phòng tắm không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có nhà tắm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có nhà tắm không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có shower không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có shower không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập xong có chỗ tắm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập xong có chỗ tắm không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tắm riêng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tắm riêng không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có phòng thay đồ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có phòng thay đồ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có changing room không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có changing room không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có nhà vệ sinh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có nhà vệ sinh không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có restroom không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có restroom không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu vệ sinh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu vệ sinh không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có locker không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có locker không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tủ đồ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tủ đồ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chỗ gửi đồ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chỗ gửi đồ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tủ cá nhân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tủ cá nhân không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi đồ ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi đồ ở đâu?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có gửi xe không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có gửi xe không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bãi xe không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bãi xe không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chỗ để xe máy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chỗ để xe máy không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chỗ để ô tô không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chỗ để ô tô không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi xe có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi xe có mất phí không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận chi tiết về phòng tắm, locker hoặc gửi xe trong FAQ. Bạn vui lòng liên hệ quầy lễ tân hoặc hotline (+84) 987-654-321 để được xác nhận trước khi đến tập.',
    N'Facilities',
    N'phòng tắm, phong tam, shower, nhà tắm, nha tam, locker, tủ đồ, tu do, gửi đồ, gui do, gửi xe, gui xe, parking, bãi xe, bai xe, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có wifi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có wifi không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Wifi phòng gym là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Wifi phòng gym là gì?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mật khẩu wifi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mật khẩu wifi không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có internet không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có internet không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có máy lạnh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có máy lạnh không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có điều hòa không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có điều hòa không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng tập có mát không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng tập có mát không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có nước uống không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có nước uống không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bình nước không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bình nước không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có bán nước không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có bán nước không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khăn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khăn không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khăn tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khăn tập không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cho thuê khăn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cho thuê khăn không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu nghỉ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu nghỉ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ghế chờ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ghế chờ không?',
    N'Hệ thống hiện chưa có dữ liệu xác nhận đầy đủ về các tiện ích này trong FAQ. Bạn vui lòng hỏi quầy lễ tân để biết cơ sở vật chất và dịch vụ đang áp dụng.',
    N'Facilities',
    N'wifi, wi-fi, internet, máy lạnh, may lanh, điều hòa, dieu hoa, nước uống, nuoc uong, khăn, khan, towel, khu nghỉ, khu khoi dong, cơ sở vật chất',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mấy giờ mở?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mấy giờ mở?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym mở cửa lúc mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym mở cửa lúc mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym mở lúc nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym mở lúc nào?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giờ mở cửa là mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giờ mở cửa là mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sáng mấy giờ mở cửa?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sáng mấy giờ mở cửa?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mấy giờ đóng?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mấy giờ đóng?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym đóng cửa lúc mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym đóng cửa lúc mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym đóng lúc nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym đóng lúc nào?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tối mấy giờ đóng cửa?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tối mấy giờ đóng cửa?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giờ đóng cửa là mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giờ đóng cửa là mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thời gian hoạt động của phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thời gian hoạt động của phòng gym?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lịch mở cửa hằng ngày?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lịch mở cửa hằng ngày?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giờ hoạt động hôm nay?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giờ hoạt động hôm nay?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym mở từ mấy giờ đến mấy giờ?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym mở từ mấy giờ đến mấy giờ?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở buổi sáng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở buổi sáng không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở buổi tối không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở buổi tối không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tập sau 21h được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tập sau 21h được không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có tập lúc 5h sáng được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có tập lúc 5h sáng được không?',
    N'Phòng gym mở cửa từ 05:00 đến 22:00 tất cả các ngày trong tuần.',
    N'Opening Hours',
    N'giờ mở cửa, gio mo cua, opening hours, mấy giờ mở, may gio mo, mấy giờ đóng, may gio dong, 05:00, 22:00, thời gian hoạt động',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở Chủ nhật không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở Chủ nhật không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chủ nhật phòng gym có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chủ nhật phòng gym có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở cuối tuần không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở cuối tuần không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thứ bảy có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thứ bảy có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cuối tuần tập được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cuối tuần tập được không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ngày lễ có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ngày lễ có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở ngày lễ không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở ngày lễ không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lịch ngày lễ thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lịch ngày lễ thế nào?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tết có mở không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tết có mở không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có mở Tết không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có mở Tết không?',
    N'Phòng gym mở cửa cả cuối tuần từ 05:00 đến 22:00. Lịch ngày lễ hoặc Tết có thể thay đổi, bạn vui lòng liên hệ hotline hoặc quầy lễ tân để xác nhận.',
    N'Opening Hours',
    N'chủ nhật, chu nhat, cuối tuần, cuoi tuan, thứ bảy, thu bay, ngày lễ, ngay le, tết, tet, holiday, weekend, lịch lễ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Địa chỉ phòng gym ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Địa chỉ phòng gym ở đâu?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Địa chỉ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Địa chỉ',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym nằm ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym nằm ở đâu?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Vị trí phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Vị trí phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym ở khu nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym ở khu nào?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chỉ đường đến phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chỉ đường đến phòng gym',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Google Map phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Google Map phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Google Map không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Google Map không?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Map đến phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Map đến phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tìm phòng gym trên bản đồ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tìm phòng gym trên bản đồ',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym ở Hòa Lạc đúng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym ở Hòa Lạc đúng không?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hotline là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hotline là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số điện thoại phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số điện thoại phòng gym?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Liên hệ qua số nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Liên hệ qua số nào?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gọi phòng gym số nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gọi phòng gym số nào?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có số tư vấn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có số tư vấn không?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Email hỗ trợ là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Email hỗ trợ là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mail hỗ trợ là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mail hỗ trợ là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi email cho phòng gym ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi email cho phòng gym ở đâu?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Support email là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Support email là gì?',
    N'Địa chỉ phòng gym là QL21 Hồ Chí Minh, Hòa Lạc, Hà Nội. Hotline: (+84) 987-654-321. Email hỗ trợ: support@gcms.com.',
    N'Contact',
    N'địa chỉ, dia chi, location, google map, bản đồ, ban do, chỉ đường, chi duong, hotline, số điện thoại, so dien thoai, email, support@gcms.com, hòa lạc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Facebook phòng gym là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Facebook phòng gym là gì?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có fanpage không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có fanpage không?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Fanpage phòng gym?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Fanpage phòng gym?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Facebook ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Facebook ở đâu?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Instagram không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Instagram không?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có Zalo không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có Zalo không?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Website phòng gym là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Website phòng gym là gì?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Trang web phòng gym ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Trang web phòng gym ở đâu?',
    N'Hệ thống hiện có website đang sử dụng để xem thông tin và đăng nhập tài khoản. Với Facebook, Zalo, Instagram hoặc kênh online khác, bạn vui lòng liên hệ hotline để được xác nhận kênh chính thức.',
    N'Contact',
    N'facebook, fanpage, fb, zalo, instagram, website, trang web, online, liên hệ online, hotline, tư vấn, tu van',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn góp ý')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn góp ý',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi góp ý như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi góp ý như thế nào?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi có đề xuất cho phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi có đề xuất cho phòng gym',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn phản hồi dịch vụ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn phản hồi dịch vụ',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đánh giá phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đánh giá phòng gym',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đánh giá dịch vụ ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đánh giá dịch vụ ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Review phòng gym thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Review phòng gym thế nào?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn khen nhân viên')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn khen nhân viên',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn khen PT')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn khen PT',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi không hài lòng thì phản ánh ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi không hài lòng thì phản ánh ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khiếu nại ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khiếu nại ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn khiếu nại')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn khiếu nại',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phàn nàn dịch vụ thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phàn nàn dịch vụ thế nào?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn báo trải nghiệm không tốt')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn báo trải nghiệm không tốt',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về thiết bị ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về thiết bị ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về vệ sinh ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về vệ sinh ở đâu?',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về cơ sở vật chất')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về cơ sở vật chất',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về thái độ phục vụ')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về thái độ phục vụ',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Góp ý về lịch PT')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Góp ý về lịch PT',
    N'Bạn có thể gửi góp ý, đánh giá hoặc khiếu nại trực tiếp tại quầy lễ tân, qua hotline (+84) 987-654-321 hoặc email support@gcms.com để được tiếp nhận và xử lý.',
    N'Feedback',
    N'góp ý, gop y, feedback, phản hồi, phan hoi, đánh giá, danh gia, review, khiếu nại, khieu nai, phàn nàn, phan nan, complaint, service',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khiếu nại có được phản hồi không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khiếu nại có được phản hồi không?',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bao lâu xử lý khiếu nại?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bao lâu xử lý khiếu nại?',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gửi feedback xong ai xử lý?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gửi feedback xong ai xử lý?',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn theo dõi phản hồi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn theo dõi phản hồi',
    N'Phòng gym sẽ tiếp nhận thông tin của bạn qua quầy lễ tân, hotline hoặc email hỗ trợ. Bạn nên cung cấp họ tên, số điện thoại và nội dung phản hồi để được kiểm tra nhanh hơn.',
    N'Feedback',
    N'khiếu nại, khieu nai, xử lý, xu ly, theo dõi phản hồi, bảo mật, hóa đơn sai, thanh toán sai, máy hỏng, feedback status',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách hoàn tiền như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách hoàn tiền như thế nào?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có hoàn tiền không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có hoàn tiền không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn hoàn tiền')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn hoàn tiền',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Refund được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Refund được không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không tập nữa có lấy lại tiền không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không tập nữa có lấy lại tiền không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách hủy gói là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách hủy gói là gì?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy gói có được hoàn tiền không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy gói có được hoàn tiền không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy gói có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy gói có mất phí không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hủy membership ra sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hủy membership ra sao?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách bảo lưu thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách bảo lưu thế nào?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bảo lưu gói được bao lâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bảo lưu gói được bao lâu?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đóng băng gói có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đóng băng gói có mất phí không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạm dừng gói có được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạm dừng gói có được không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách chuyển nhượng thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách chuyển nhượng thế nào?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chuyển nhượng gói có điều kiện gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chuyển nhượng gói có điều kiện gì?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sang tên gói có mất phí không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sang tên gói có mất phí không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có thể chuyển gói cho bạn bè không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có thể chuyển gói cho bạn bè không?',
    N'Các chính sách hoàn tiền, hủy gói, bảo lưu hoặc chuyển nhượng có thể phụ thuộc vào tình trạng gói và từng trường hợp cụ thể. Bạn vui lòng liên hệ quầy lễ tân để được xác nhận chính xác.',
    N'Policies',
    N'chính sách, chinh sach, policy, hoàn tiền, hoan tien, refund, hủy gói, huy goi, bảo lưu, bao luu, chuyển nhượng, chuyen nhuong, transfer',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Chính sách hội viên là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Chính sách hội viên là gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Quy định hội viên gồm những gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Quy định hội viên gồm những gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nội quy phòng tập là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nội quy phòng tập là gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đi tập cần tuân thủ gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đi tập cần tuân thủ gì?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quy định trang phục không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quy định trang phục không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được mang đồ ăn vào phòng tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được mang đồ ăn vào phòng tập không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được quay video không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được quay video không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được dẫn bạn vào tập cùng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được dẫn bạn vào tập cùng không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Khách vãng lai có được vào không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Khách vãng lai có được vào không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có chính sách cho người bị chấn thương không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có chính sách cho người bị chấn thương không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bị ốm có được bảo lưu không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bị ốm có được bảo lưu không?',
    N'Bạn vui lòng tuân thủ hướng dẫn của phòng gym, sử dụng thiết bị đúng cách, giữ vệ sinh và tôn trọng người tập khác. Với các chính sách chi tiết như trang phục, quay video, khách đi cùng hoặc bảo mật thông tin, vui lòng liên hệ lễ tân để được xác nhận.',
    N'Policies',
    N'nội quy, noi quy, quy định, quy dinh, chính sách hội viên, membership policy, trang phục, quay video, khách đi cùng, bảo mật, privacy, chấn thương',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Quên mật khẩu thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Quên mật khẩu thì làm sao?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi quên mật khẩu')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi quên mật khẩu',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Forgot password ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Forgot password ở đâu?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt lại mật khẩu như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt lại mật khẩu như thế nào?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Reset password thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Reset password thế nào?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không đăng nhập được')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không đăng nhập được',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tại sao tôi không đăng nhập được?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tại sao tôi không đăng nhập được?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đăng nhập bị lỗi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đăng nhập bị lỗi',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sai mật khẩu thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sai mật khẩu thì làm sao?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tài khoản bị khóa thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tài khoản bị khóa thì làm sao?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không nhận được email xác thực')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không nhận được email xác thực',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần xác thực email không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần xác thực email không?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Verify email như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Verify email như thế nào?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kích hoạt tài khoản ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kích hoạt tài khoản ở đâu?',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi chưa kích hoạt tài khoản')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi chưa kích hoạt tài khoản',
    N'Bạn có thể dùng chức năng Quên mật khẩu tại trang đăng nhập. Nếu không đăng nhập được hoặc chưa xác thực email, vui lòng kiểm tra lại email, mật khẩu và liên hệ lễ tân nếu cần hỗ trợ thêm.',
    N'Account',
    N'quên mật khẩu, quen mat khau, forgot password, reset password, không đăng nhập, khong dang nhap, login error, verify email, xác thực email, kích hoạt tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi mật khẩu như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi mật khẩu như thế nào?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi mật khẩu')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi mật khẩu',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Change password ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Change password ở đâu?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mật khẩu mới đặt ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mật khẩu mới đặt ở đâu?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi password được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi password được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi email được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi email được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi email')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi email',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sửa email tài khoản')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sửa email tài khoản',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Email sai thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Email sai thì làm sao?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật email mới')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật email mới',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi số điện thoại được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi số điện thoại được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn đổi số điện thoại')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn đổi số điện thoại',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sửa phone tài khoản')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sửa phone tài khoản',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Số điện thoại sai thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Số điện thoại sai thì làm sao?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật số điện thoại mới')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật số điện thoại mới',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật hồ sơ cá nhân ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật hồ sơ cá nhân ở đâu?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Sửa thông tin cá nhân')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Sửa thông tin cá nhân',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi tên tài khoản được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi tên tài khoản được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đổi ảnh đại diện được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đổi ảnh đại diện được không?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cập nhật profile như thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cập nhật profile như thế nào?',
    N'Sau khi đăng nhập, bạn có thể vào Hồ sơ cá nhân hoặc Đổi mật khẩu để cập nhật thông tin mà hệ thống cho phép. Nếu không chỉnh sửa được email hoặc số điện thoại, vui lòng liên hệ lễ tân để được hỗ trợ.',
    N'Account',
    N'đổi mật khẩu, doi mat khau, change password, đổi email, doi email, đổi số điện thoại, doi so dien thoai, profile, hồ sơ cá nhân, ho so ca nhan, cập nhật tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tài khoản của tôi có thông tin gói tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tài khoản của tôi có thông tin gói tập không?',
    N'Tài khoản giúp bạn theo dõi thông tin cá nhân, gói tập, hóa đơn và thông báo. Với các vấn đề bảo mật, trùng thông tin hoặc yêu cầu ngừng sử dụng tài khoản, bạn vui lòng liên hệ quầy lễ tân để được kiểm tra.',
    N'Account',
    N'tài khoản, tai khoan, account, profile, thông tin hội viên, logout, đăng xuất, bảo mật tài khoản, email trùng, phone trùng, xóa tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem thông tin hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem thông tin hội viên ở đâu?',
    N'Tài khoản giúp bạn theo dõi thông tin cá nhân, gói tập, hóa đơn và thông báo. Với các vấn đề bảo mật, trùng thông tin hoặc yêu cầu ngừng sử dụng tài khoản, bạn vui lòng liên hệ quầy lễ tân để được kiểm tra.',
    N'Account',
    N'tài khoản, tai khoan, account, profile, thông tin hội viên, logout, đăng xuất, bảo mật tài khoản, email trùng, phone trùng, xóa tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem profile hội viên ở đâu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem profile hội viên ở đâu?',
    N'Tài khoản giúp bạn theo dõi thông tin cá nhân, gói tập, hóa đơn và thông báo. Với các vấn đề bảo mật, trùng thông tin hoặc yêu cầu ngừng sử dụng tài khoản, bạn vui lòng liên hệ quầy lễ tân để được kiểm tra.',
    N'Account',
    N'tài khoản, tai khoan, account, profile, thông tin hội viên, logout, đăng xuất, bảo mật tài khoản, email trùng, phone trùng, xóa tài khoản',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym phù hợp cho người mới không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym phù hợp cho người mới không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Người mới tập nên bắt đầu thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Người mới tập nên bắt đầu thế nào?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi mới tập gym cần chuẩn bị gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi mới tập gym cần chuẩn bị gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lần đầu đến phòng gym cần làm gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lần đầu đến phòng gym cần làm gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đi tập cần mang gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đi tập cần mang gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mang giày riêng không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mang giày riêng không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mang khăn không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mang khăn không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần mang nước không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần mang nước không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nên mặc đồ gì khi tập?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nên mặc đồ gì khi tập?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có ai hướng dẫn người mới không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có ai hướng dẫn người mới không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi chưa biết tập thì hỏi ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi chưa biết tập thì hỏi ai?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập sai kỹ thuật thì làm sao?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập sai kỹ thuật thì làm sao?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần thuê PT khi mới tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần thuê PT khi mới tập không?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn giảm cân thì nên tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn giảm cân thì nên tập gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tăng cơ thì nên tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tăng cơ thì nên tập gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn cải thiện tim mạch thì tập gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn cải thiện tim mạch thì tập gì?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập yoga thì chọn ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập yoga thì chọn ai?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập boxing thì chọn ai?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập boxing thì chọn ai?',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tư vấn dinh dưỡng')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tư vấn dinh dưỡng',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn phục hồi thể lực')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn phục hồi thể lực',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập nhẹ nhàng')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập nhẹ nhàng',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn tập cường độ cao')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn tập cường độ cao',
    N'Người mới nên bắt đầu với cường độ vừa phải, sử dụng thiết bị đúng kỹ thuật và hỏi nhân viên hoặc PT khi cần. Nếu có mục tiêu cụ thể như giảm cân, tăng cơ, cardio, yoga, boxing hoặc dinh dưỡng, bạn có thể tham khảo dịch vụ PT phù hợp.',
    N'General Gym Information',
    N'người mới, nguoi moi, beginner, tập gym, tap gym, chuẩn bị, chuan bi, giảm cân, giam can, tăng cơ, tang co, cardio, yoga, boxing, dinh dưỡng, dinh duong, PT',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Phòng gym có những khu vực nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Phòng gym có những khu vực nào?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Gym rooms gồm những gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Gym rooms gồm những gì?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tạ tự do không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tạ tự do không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tập ngực không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tập ngực không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu tập chân không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu tập chân không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu yoga không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu yoga không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có khu boxing không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có khu boxing không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có phòng riêng cho PT không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có phòng riêng cho PT không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lớp học nhóm không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lớp học nhóm không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lớp yoga không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lớp yoga không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lớp cardio không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lớp cardio không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lịch lớp học không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lịch lớp học không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có lịch trình tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có lịch trình tập không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi muốn xem lịch tập')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi muốn xem lịch tập',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có quy định vệ sinh không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có quy định vệ sinh không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tập xong có cần lau máy không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tập xong có cần lau máy không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có cần cất tạ sau khi tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có cần cất tạ sau khi tập không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được chiếm máy lâu không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được chiếm máy lâu không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được mang trẻ em vào không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được mang trẻ em vào không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được mang thú cưng vào không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được mang thú cưng vào không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được chụp ảnh trong phòng gym không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được chụp ảnh trong phòng gym không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được quay video tập luyện không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được quay video tập luyện không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Có được ăn uống trong khu tập không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Có được ăn uống trong khu tập không?',
    N'Dữ liệu hiện có ghi nhận khu Cardio và khu tập tạ tự do. Với các khu vực, lớp học hoặc quy định chi tiết khác, bạn vui lòng liên hệ quầy lễ tân để được xác nhận trước khi đến tập.',
    N'General Gym Information',
    N'gym rooms, phòng tập, phong tap, khu tập, khu tap, cardio, tạ tự do, ta tu do, lớp học, lop hoc, lịch tập, lich tap, quy định, vệ sinh, ve sinh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạm biệt')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạm biệt',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Bye')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Bye',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Goodbye')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Goodbye',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hẹn gặp lại')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hẹn gặp lại',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn bạn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn bạn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thanks')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thanks',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thank you')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thank you',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Ok cảm ơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Ok cảm ơn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Được rồi cảm ơn')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Được rồi cảm ơn',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi hiểu rồi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi hiểu rồi',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Không cần nữa')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Không cần nữa',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tôi hỏi sau')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tôi hỏi sau',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kết thúc chat')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kết thúc chat',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Dừng chat')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Dừng chat',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạm thời vậy thôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạm thời vậy thôi',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn chatbot')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn chatbot',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cảm ơn phòng gym')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cảm ơn phòng gym',
    N'Cảm ơn bạn đã liên hệ. Nếu cần thêm thông tin, bạn có thể quay lại chat, gọi hotline (+84) 987-654-321 hoặc gửi email support@gcms.com.',
    N'Goodbye',
    N'tạm biệt, tam biet, bye, goodbye, cảm ơn, cam on, thanks, thank you, hẹn gặp lại, hen gap lai, kết thúc chat, ket thuc chat',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Thời tiết hôm nay thế nào?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Thời tiết hôm nay thế nào?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'thời tiết, thoi tiet, weather, hôm nay, dự báo',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá vàng hôm nay bao nhiêu?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá vàng hôm nay bao nhiêu?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'giá vàng, gia vang, gold price, vàng, sjc',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Giá đô la hôm nay?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Giá đô la hôm nay?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'đô la, dollar, usd, tỷ giá, exchange rate',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'AI là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'AI là gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'ai là gì, artificial intelligence, trí tuệ nhân tạo',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Viết code Java giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Viết code Java giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'java, code, lập trình, programming, servlet',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Làm bài tập giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Làm bài tập giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bài tập, homework, assignment, làm hộ',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kết quả bóng đá hôm nay?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kết quả bóng đá hôm nay?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bóng đá, bong da, football, soccer, kết quả',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Lịch thi đấu World Cup?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Lịch thi đấu World Cup?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'world cup, lịch thi đấu, football schedule',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Facebook của tôi bị khóa')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Facebook của tôi bị khóa',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'facebook, khóa tài khoản, mạng xã hội',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Google là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Google là gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'google, search engine, tìm kiếm',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mua điện thoại nào tốt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mua điện thoại nào tốt?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'điện thoại, phone, smartphone, mua gì',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn mua laptop')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn mua laptop',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'laptop, máy tính, computer, tư vấn mua',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt vé máy bay giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt vé máy bay giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'vé máy bay, flight, ticket, travel',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Đặt khách sạn giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Đặt khách sạn giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'khách sạn, hotel, booking, travel',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Hôm nay ăn gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Hôm nay ăn gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'ăn gì, món ăn, food, dinner',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Cách nấu phở')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Cách nấu phở',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'nấu ăn, phở, recipe, cooking',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn chứng khoán')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn chứng khoán',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'chứng khoán, stock, cổ phiếu, đầu tư',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn tiền ảo')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn tiền ảo',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bitcoin, crypto, tiền ảo, coin',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Xem tử vi hôm nay')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Xem tử vi hôm nay',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'tử vi, horoscope, bói toán',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Dịch tiếng Anh giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Dịch tiếng Anh giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'dịch, translate, english, tiếng anh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Viết bài văn giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Viết bài văn giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bài văn, essay, viết văn',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tạo ảnh AI giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tạo ảnh AI giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'tạo ảnh, image generation, ai image',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Kể chuyện cười')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Kể chuyện cười',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'chuyện cười, joke, vui',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Nghe nhạc được không?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Nghe nhạc được không?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'nhạc, music, bài hát, song',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tải video YouTube giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tải video YouTube giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'youtube, download video, tải video',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mật khẩu wifi nhà tôi là gì?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mật khẩu wifi nhà tôi là gì?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'wifi nhà, mật khẩu riêng, password',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tìm việc làm giúp tôi')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tìm việc làm giúp tôi',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'việc làm, job, tuyển dụng',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn pháp luật')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn pháp luật',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'pháp luật, legal, luật sư',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Tư vấn bệnh án')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Tư vấn bệnh án',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bệnh án, medical, doctor, sức khỏe bệnh',
    N'Active'
);

END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.FAQ WHERE question = N'Mua bảo hiểm nào tốt?')
BEGIN

INSERT INTO dbo.FAQ
(
    question,
    answer,
    category,
    keywords,
    status
)
VALUES
(
    N'Mua bảo hiểm nào tốt?',
    N'Xin lỗi, câu hỏi của bạn nằm ngoài phạm vi hỗ trợ của chúng tôi.

Vui lòng liên hệ qua email hoặc số điện thoại để được hỗ trợ thêm.',
    N'Out Of Scope',
    N'bảo hiểm, insurance, mua bảo hiểm',
    N'Active'
);

END;
GO

